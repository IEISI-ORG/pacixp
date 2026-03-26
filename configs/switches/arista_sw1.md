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
   mtu 9214
   ip address 198.51.100.64/31
   ipv6 address 3fff:0:3::/127
!
! Interface facing the Peer Switch (SW2)
interface Ethernet2
   description INFRA: ISL-TO-SW2
   no switchport
   mtu 9214
   ip address 198.51.100.66/31
   ipv6 address 3fff:0:3::2/127
!
! Loopback for VTEP (VXLAN Source)
interface Loopback0
   description EVPN-VTEP-SOURCE
   ip address 198.51.100.11/32
   ipv6 address 3fff:0:2::11/128
!
! Management Interface
interface Management1
   description OOB-MANAGEMENT
   vrf MGMT
   ip address 203.0.113.11/24
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
   ! BUM replication is handled dynamically via EVPN Type 3 routes.
   ! No static VTEP flood list is needed. Remote VTEPs are discovered
   ! automatically through the BGP EVPN confederation control plane.
!
! ------------------------------------------------------------------
! ROUTING - UNDERLAY (OSPF)
! ------------------------------------------------------------------
! Distribute Loopback IPs so VTEPs can reach each other
router ospf 1
   router-id 198.51.100.11
   passive-interface default
   no passive-interface Ethernet1
   no passive-interface Ethernet2
   network 198.51.100.11/32 area 0.0.0.0
   network 198.51.100.64/26 area 0.0.0.0
   max-lsa 12000
!
! ------------------------------------------------------------------
! ROUTING - OVERLAY (BGP EVPN CONFEDERATION)
! ------------------------------------------------------------------
! This switch is in sub-AS 64501 (Site A: Samoa).
! The confederation identifier 64500 is the externally-visible AS.
! Route Targets reference the confederation ID (64500), not the sub-AS.
!
! BGP topology mirrors the physical topology:
!   - Intra-site ISL  <-->  iBGP session (same sub-AS)
!   - Inter-site VXLAN  <-->  confederation eBGP session (different sub-AS)
router bgp 64501
   bgp confederation identifier 64500
   bgp confederation peers 64502 64503
   router-id 198.51.100.11
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   !
   ! Intra-Site: SW2 shares sub-AS 64501 — standard iBGP behavior.
   ! This session mirrors the physical ISL between SW1 and SW2.
   neighbor 198.51.100.12 remote-as 64501
   neighbor 198.51.100.12 update-source Loopback0
   neighbor 198.51.100.12 description iBGP-INTRASITE-SW2
   neighbor 198.51.100.12 send-community extended
   neighbor 198.51.100.12 timers 10 30
   !
   ! Inter-Site: Site B SW1 is in sub-AS 64502 — confederation eBGP.
   ! This session mirrors the physical VXLAN tunnel to Site B.
   ! If this WAN path experiences jitter/flapping, increase to timers 30 90.
   neighbor 198.51.100.21 remote-as 64502
   neighbor 198.51.100.21 update-source Loopback0
   neighbor 198.51.100.21 description CONFED-EBGP-SITE-B-SW1
   neighbor 198.51.100.21 send-community extended
   neighbor 198.51.100.21 timers 10 30
   !
   address-family evpn
      neighbor 198.51.100.12 activate
      neighbor 198.51.100.21 activate
      ! Critical: preserve the originating VTEP's Loopback IP as the
      ! EVPN next-hop across the confederation eBGP boundary. Without
      ! this, the remote VTEP IP is overwritten and VXLAN encapsulation
      ! will target the wrong destination.
      neighbor 198.51.100.21 next-hop-unchanged
   !
   ! VLAN-Aware Bundle
   ! Route targets use the confederation identifier 64500 — consistent
   ! across all sites regardless of sub-AS assignment.
   vlan 10
      rd 198.51.100.11:10010
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
sflow source 198.51.100.11
sflow destination 203.0.113.50
sflow polling-interval 20
sflow sample 1024
sflow run
!
end
```
