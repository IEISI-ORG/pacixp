# PacIXP Security Hardening Guide

| Document Details | |
| :--- | :--- |
| **Project** | Pacific Islands Internet Exchange (PacIXP) |
| **Domain** | Infrastructure Security & Information Assurance |
| **Compliance** | **MANRS for IXPs**, Euro-IX BCP |
| **Enforcement** | Mandatory on all production nodes |

---

## 1. Security Philosophy

The security model of PacIXP is based on the **"Zero Trust Fabric"** principle.
1.  **Protect the Fabric:** No single member should be able to disrupt the exchange for others (Loop prevention, Storm control).
2.  **Protect the Routing:** Route Servers must filter bad routing data (RPKI, Bogons).
3.  **Protect the Management:** The control plane must be isolated from the peering plane.

---

## 2. Layer 2 Hardening (Switching Fabric)

The Peering LAN is the most vulnerable component. These controls are applied **per-port** on member-facing interfaces.

### 2.1 MAC Address Hygiene
Traditional learning bridges are dangerous in IXP environments.
*   **No Dynamic MAC Learning:** Disable basic MAC learning on peering ports if the platform supports it.
*   **MAC Locking / Port Security:**
    *   **Rule:** Allow exactly **1 MAC address** per member port.
    *   **Action:** `Shutdown` (preferred for security) or `Discard` (preferred for uptime).
    *   **Exceptions:** Reseller ports (QinQ) may require higher limits, but must be strictly documented.

### 2.2 Traffic Storm Control
Prevents a malfunctioning member router from flooding the fabric with BUM (Broadcast, Unknown-Unicast, Multicast) traffic.
*   **Broadcast Limit:** 1% of link speed (or 10 Mbps).
*   **Multicast Limit:** 1% of link speed (or 10 Mbps).
*   **Unknown Unicast:** Drop completely (since we use MAC locking, unknown traffic shouldn't exist).

### 2.3 Protocol Filtering (The "Clean Pipe" ACL)
Applied as an Ingress ACL on every member port.

| Protocol | Type/Port | Action | Reason |
| :--- | :--- | :--- | :--- |
| **IPv6 ICMP** | Type 134 (Router Advertisement) | **DROP** | **CRITICAL:** Prevents members from accidentally becoming the IPv6 Gateway for the entire exchange. |
| **IPv6 ICMP** | Type 135/136 (NDP) | **PERMIT** | Required for neighbor discovery. |
| **UDP** | 67, 68 (DHCPv4) | **DROP** | Prevent rogue DHCP servers. |
| **UDP** | 546, 547 (DHCPv6) | **DROP** | Prevent rogue DHCPv6 servers. |
| **OSPF/EIGRP/IS-IS** | Multicast ranges | **DROP** | IGP protocols should not leak onto the IXP fabric. |
| **STP** | BPDU | **DROP** | **BPDU Guard** must also be enabled to shut down ports sending BPDUs. |
| **CDP / LLDP** | - | **DISABLE** | Do not leak topology info to members. |

---

## 3. Layer 3 Hardening (Route Servers)

The Route Servers (RS) act as the trust brokers. We use **BIRD 2.x** to enforce strict routing hygiene.

### 3.1 MANRS Compliance Actions
PacIXP adheres to the [MANRS IXP Programme](https://www.manrs.org/).

*   **Action 1 (Prevent Incorrect Routing):**
    *   **RPKI (Route Origin Validation):** Connect BIRD to a local validator (e.g., Routinator). **Reject** all `RPKI_INVALID` routes.
    *   **IRR Filtering:** Use `bgpq4` to generate prefix lists from the member's `AS-SET` in PeeringDB/RADB. Reject prefixes not in the IRR.
    *   **Bogon Filtering:** Reject all RFC1918 (Private), RFC5735 (Special Use), and Multicast ranges.
    *   **Max-Prefix Limits:** Set a hard limit (e.g., 120% of current table size). If exceeded, tear down the BGP session to protect RS RAM/CPU.

*   **Action 2 (Prevent Spoofing):**
    *   **uRPF (Unicast Reverse Path Forwarding):** Enabled on switch ports where hardware supports it (loose mode).
    *   **ACLs:** Ingress ACLs on the switch allowing traffic *only* from the member's assigned IXP IP address.

### 3.2 BGP Session Security
*   **MD5 Passwords:** Optional (adds complexity), but supported if requested.
*   **GTSM (Generalized TTL Security Mechanism):**
    *   Enforce `TTL=255` on BGP packets.
    *   Rejects packets coming from multiple hops away.
*   **No Export:** Route Servers must typically configured with `export: none` (transparent) or extremely strict export filters so they don't leak the global routing table to members.

---

## 4. Infrastructure & Control Plane Hardening

Protecting the equipment that runs the IXP.

### 4.1 Management Access
*   **Out-of-Band (OOB) Only:**
    *   Management ports (`eth0`/`Ma1`) connected to a physically separate switch/VRF.
    *   **NO** management access permitted via the Peering LAN IPs.
*   **Console Access:**
    *   Serial console servers (Opengear/Airconsole) required for remote recovery.
*   **Access Control:**
    *   SSH Key-based authentication **only** (Password auth disabled).
    *   Limit SSH/SNMP access to specific administrative Subnets/VPNs.

### 4.2 Switch CoPP (Control Plane Policing)
*   Configure CoPP policies to strictly limit traffic sent to the switch CPU.
*   Prioritize: LACP, BGP, SSH.
*   Drop/Rate-limit: ICMP, ARP floods.

### 4.3 Physical Security
*   **Cabinet Locks:** All racks must be locked.
*   **Cabling:** Fiber paths should be in protective trays (yellow duct).
*   **Labeling:** Every cable must be labeled at both ends (Member Name / Port ID).

---

## 5. Ongoing Operational Security

Security is a process, not a config file.

### 5.1 Pre-Flight Check (Member Onboarding)
Before enabling a member port `no shutdown`:
1.  [ ] **Quarantine VLAN:** Place port in a quarantine VLAN first.
2.  [ ] **Light Check:** Verify optical levels are within range.
3.  [ ] **MAC Check:** Verify member is broadcasting only 1 MAC address.
4.  [ ] **Packet Capture:** Run `tcpdump` to ensure no STP, CDP, or spurious UDP traffic is leaking.
5.  [ ] **Move to Prod:** Only then move to VLAN 10 (Peering LAN).

### 5.2 Regular Audits
*   **Daily:** Automated check of RPKI validator status.
*   **Weekly:** IXP Manager updates prefix filters (IRR data).
*   **Monthly:** Audit "Parking VLAN" (ports administratively down).
*   **Quarterly:** Review ACLs and Firmware versions for CVEs.

### 5.3 Incident Response Contacts
In the event of a security incident (DDoS, Route Hijack):

*   **Internal Emergency:** `noc@PacIXP.net` / `+679-XXX-XXXX`
*   **Upstream CERT:** [PacCERT / APNIC CERT Contact]
*   **Global Reach:** [PeeringDB Entry URL]

---

## 6. Implementation Checklist for Engineers

Copy this into the deployment ticket.

- [ ] **Switch:** Root password changed and SSH keys deployed.
- [ ] **Switch:** Unused ports shut down.
- [ ] **Switch:** `service password-encryption` enabled.
- [ ] **Switch:** NTP configured (critical for logs).
- [ ] **Fabric:** IPv6 RA Guard verified active.
- [ ] **Fabric:** Storm Control verified active.
- [ ] **RS:** BIRD RPKI protocol `Established` with Routinator.
- [ ] **RS:** Firewall (iptables/nftables) locked down to BGP (179) and SSH (22).
- [ ] **Mgmt:** Serial Console accessible remotely.
