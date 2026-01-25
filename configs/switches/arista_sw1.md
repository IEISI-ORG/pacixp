This is an example configuration file for **Switch 1 (SW1)** using **Arista EOS**.

It implements the security policies defined in the hardening guide and the EVPN-VXLAN architecture defined in the HLD.

### ⚠️ IMPORTANT ENGINEERING WARNING

> **THIS IS A REFERENCE CONFIGURATION TEMPLATE.**
>
> While this configuration is syntactically correct for Arista EOS, it contains example IP addresses, passwords, and interface IDs.
> **DO NOT DEPLOY THIS TO PRODUCTION WITHOUT MODIFICATION.**
>
> 1.  **Change all Passwords/Secrets** immediately.
> 2.  **Verify Interface Assignments** against your physical cabling plan.
> 3.  **Validate IP Addressing** against the `02-addressing-plan.md`.
> 4.  **Test Failure Scenarios** in a lab environment before connecting members.

---

### File: `configs/switches/arista/sw1-example.cfg`

```eos
! device: PacIX-SiteA-SW1 (DCS-7050SX3-48YC8)
! boot system flash:/EOS-4.28.0F.swi
!
! ------------------------------------------------------------------
! SYSTEM & MANAGEMENT
! ------------------------------------------------------------------
hostname PacIX-SiteA-SW1
!
! Dedicated Management VRF to isolate control plane from data plane
vrf definition MGMT
   rd 64500:999
!
username admin privilege 15 secret sha512 $6$SALT$HASH_GOES_HERE...
!
! Enable routing (IPv4 and IPv6)
service routing protocols model multi-agent
ip routing
ipv6 unicast-routing
!
! Spanning Tree (Rapid-PVST as fail-safe, though VXLAN eliminates loops)
spanning-tree mode rapid-pvst
spanning-tree edge-port bpduguard default
!
! ------------------------------------------------------------------
! SECURITY ACLs (The "Clean Pipe")
! ------------------------------------------------------------------
!
! IPv4: Block DHCP servers, allow everything else
ip access-list ACL-IXP-PEERING-V4
   10 remark "Block DHCP BootP Server/Relay"
   20 deny udp any any eq bootps
   30 deny udp any any eq bootpc
   40 remark "Permit all other IXP traffic"
   50 permit ip any any
!
! IPv6: Block RA (Router Advertisements) and DHCPv6 Servers
ipv6 access-list ACL-IXP-PEERING-V6
   10 remark "Block IPv6 Router Advertisements (Critical)"
   20 deny icmp any any router-advertisement
   30 remark "Block DHCPv6 Server"
   40 deny udp any any eq dhcpv6-server
   50 remark "Permit all other IXP traffic"
   60 permit ipv6 any any
!
! ------------------------------------------------------------------
! VLAN CONFIGURATION
! ------------------------------------------------------------------
vlan 10
   name IXP-PEERING-LAN
   state active
!
vlan 999
   name QUARANTINE
   state active
!
! ------------------------------------------------------------------
! INTERFACES - INFRASTRUCTURE (Underlay & Uplinks)
! ------------------------------------------------------------------
!
! Interface facing the Site Gateway / WAN
interface Ethernet1
   description INFRA: UPLINK-TO-WAN-RTR
   no switchport
   ip address 172.16.0.1/31
   ipv6 enable
!
! Interface facing the Peer Switch (SW2)
interface Ethernet2
   description INFRA: ISL-TO-SW2
   no switchport
   ip address 172.16.0.3/31
   ipv6 enable
!
! Loopback for VTEP (VXLAN Source)
interface Loopback0
   description EVPN-VTEP-SOURCE
   ip address 10.0.0.11/32
   ipv6 address fd00::11/128
!
! Management Interface
interface Management1
   description OOB-MANAGEMENT
   vrf MGMT
   ip address 192.168.100.11/24
!
! ------------------------------------------------------------------
! INTERFACES - IXP MEMBERS
! ------------------------------------------------------------------
!
! Example Member Port
interface Ethernet3
   description MEMBER: ISP-A (AS65001)
   ! Layer 2 Configuration
   switchport mode access
   switchport access vlan 10
   !
   ! Security Application
   ip access-group ACL-IXP-PEERING-V4 in
   ipv6 traffic-filter ACL-IXP-PEERING-V6 in
   !
   ! Port Security / Hygiene
   storm-control broadcast level 1.0
   storm-control multicast level 1.0
   switchport port-security maximum 1
   switchport port-security violation protect
   !
   ! Spanning Tree & Discovery hardening
   spanning-tree portfast
   spanning-tree bpduguard enable
   no lldp transmit
   no lldp receive
   !
   ! State
   no shutdown
!
! Example Unused Port (Secure Default)
interface Ethernet4
   description SPARE
   switchport access vlan 999
   shutdown
!
! ------------------------------------------------------------------
! VXLAN OVERLAY CONFIGURATION
! ------------------------------------------------------------------
interface Vxlan1
   description VTEP-OVERLAY
   vxlan source-interface Loopback0
   vxlan udp-port 4789
   ! Map VLAN 10 to VNI 10010
   vxlan vlan 10 vni 10010
   ! Head-end Replication (Flood to other VTEPs list)
   vxlan vlan 10 flood vtep 10.0.0.12 10.0.0.21 10.0.0.22
!
! ------------------------------------------------------------------
! ROUTING - UNDERLAY (OSPF)
! ------------------------------------------------------------------
! Distribute Loopback IPs so VTEPs can reach each other
router ospf 1
   router-id 10.0.0.11
   passive-interface default
   no passive-interface Ethernet1
   no passive-interface Ethernet2
   network 10.0.0.11/32 area 0.0.0.0
   network 172.16.0.0/24 area 0.0.0.0
   max-lsa 12000
!
! ------------------------------------------------------------------
! ROUTING - OVERLAY (BGP EVPN)
! ------------------------------------------------------------------
router bgp 64500
   router-id 10.0.0.11
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   !
   ! Peer with SW2 (Same Site)
   neighbor 10.0.0.12 remote-as 64500
   neighbor 10.0.0.12 update-source Loopback0
   neighbor 10.0.0.12 description iBGP-PEER-SW2
   neighbor 10.0.0.12 send-community
   !
   ! Peer with Site B (Remote Site) - Full Mesh or Route Reflector
   neighbor 10.0.0.21 remote-as 64500
   neighbor 10.0.0.21 update-source Loopback0
   neighbor 10.0.0.21 description iBGP-PEER-SITE-B-SW1
   neighbor 10.0.0.21 send-community
   !
   ! EVPN Address Family
   address-family evpn
      neighbor 10.0.0.12 activate
      neighbor 10.0.0.21 activate
   !
   ! VLAN-Aware Bundle
   vlan 10
      rd 10.0.0.11:10010
      route-target import 64500:10010
      route-target export 64500:10010
      redistribute learned
!
! ------------------------------------------------------------------
! MANAGEMENT SERVICES
! ------------------------------------------------------------------
!
! SNMP for Monitoring (IXP Manager)
snmp-server community pacix-public ro
!
! NTP (Critical for logs)
ntp server 0.pool.ntp.org
!
! SFlow (Traffic Analysis)
sflow source 10.0.0.11
sflow destination 192.168.100.50
sflow polling-interval 20
sflow sample 1024
sflow run
!
end
```
