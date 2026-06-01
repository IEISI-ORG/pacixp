# PACIXP Security Hardening Guide

| Document Details | |
| :--- | :--- |
| **Project** | Pacific Islands Internet Exchange (PACIXP) |
| **Domain** | Infrastructure Security & Information Assurance |
| **Compliance** | **MANRS for IXPs**, Euro-IX BCP |
| **Enforcement** | Mandatory on all production nodes |

---

## 1. Security Philosophy

The security model of PACIXP is based on the **"Zero Trust Fabric"** principle.
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
PACIXP adheres to the [MANRS IXP Programme](https://www.manrs.org/ixps/actions/). The programme defines five actions; Actions 1 and 2 are mandatory. PACIXP implements all five. The two actions with direct security-config implications are detailed below; Actions 2, 4, and 5 are covered in the onboarding and operational docs.

*   **Action 1 — Prevent propagation of incorrect routing information (Mandatory):**

    Route filtering uses two independent layers applied in sequence on every inbound route. Both must pass for a route to be accepted.

    **Layer 1 — IRR Prefix Filter (always active, inner gate)**
    *   Each member must register an AS-SET in a public IRR (RADB, RIPE, or APNIC) as a condition of membership.
    *   `bgpq4` recursively expands the AS-SET to produce a prefix-list for that member.
    *   IXP Manager refreshes these prefix-lists every 15 minutes via cron.
    *   Any prefix not in the member's AS-SET is rejected unconditionally, regardless of RPKI state.
    *   This layer operates even when the RPKI validator is unreachable. It limits the blast radius of a RPKI cache outage to routes that are within the member's own declared policy.
    *   **Membership requirement:** overly broad AS-SETs (e.g., `AS-ANY`) are not acceptable. The IXP operator must verify AS-SET scope at onboarding and periodically audit for inflation.

    **Layer 2 — RPKI Route Origin Validation (outer gate)**
    *   BIRD connects to a local Routinator instance via RTR protocol.
    *   Routes with `RPKI_INVALID` origin are **rejected unconditionally**.
    *   Routes with `RPKI_UNKNOWN` are accepted during initial rollout but the target is full ROV enforcement once members have established ROAs.
    *   If the RPKI cache becomes unreachable, route servers must **fail closed** (reject or hold) rather than accepting all routes as valid. Layer 1 (IRR) continues to provide filtering during any RPKI outage.

    **Additional filters applied to all sessions:**
    *   **Bogon Filtering:** Reject RFC1918, RFC5735 (Special Use), and Multicast ranges.
    *   **Max-Prefix Limits:** Tear down the BGP session if a member announces more than 120% of their expected prefix count. Protects RS RAM/CPU from route table injection attacks.

*   **Action 3 — Protect the peering platform:**
    *   **Ethertype filtering (L2):** Each member port allows only EtherType 0x0800 (IPv4), 0x0806 (ARP), and 0x86DD (IPv6). All other ethertypes are dropped — this blocks CDP, STP, LLDP, LACP, DHCP, and all other non-IP control-plane protocols at the frame level.
    *   **MAC address locking:** Each member port is statically bound to a single MAC address. Frames sourced from any other MAC are dropped by the switch.
    *   **Storm control:** Broadcast and multicast capped at ≤ 1% of link capacity on all member ports (stricter than the MANRS-recommended 10%).
    *   **Source IP filtering (additional):** Ingress port ACLs (PACLs) allow traffic only from the member's assigned IXP IP address. This is PACIXP policy beyond the MANRS L2 baseline. uRPF is not applicable — member ports are Layer 2 switchports.

### 3.2 BGP Session Security
*   **MD5 Passwords:** Not recommended on RS sessions. MD5 provides no meaningful protection against on-path attackers in 2025 and adds rotation overhead without benefit over GTSM + source-IP ACLs already in place. If a member insists, document the operational overhead and require a change-management window for key rotation.
*   **GTSM (Generalized TTL Security Mechanism):**
    *   Enforce `TTL=255` on BGP packets.
    *   Rejects packets coming from multiple hops away.
*   **No Export:** Route Servers must typically configured with `export: none` (transparent) or extremely strict export filters so they don't leak the global routing table to members.

### 3.3 BGP Community Policy (RTBH)

PACIXP implements **RFC 7999 Remotely Triggered Black Hole (RTBH)** as the sole supported BGP community action. No other communities are processed by the route servers.

| Attribute | Value |
| :--- | :--- |
| **Community** | `65535:666` (RFC 7999) |
| **Accepted prefix lengths** | `/32` (IPv4) and `/128` (IPv6) only |
| **Discard next-hop (IPv4)** | `192.0.2.0` |
| **Discard next-hop (IPv6)** | `3fff:0:1::` |
| **Auto-added by RS** | `NO_EXPORT (65535:65281)` |

**How the RS processes an RTBH request:**
1. A member announces a victim /32 with community `65535:666` to the RS.
2. The RS validates the prefix length — broader prefixes are rejected to prevent a member from accidentally silencing a whole block.
3. The RS rewrites the next-hop to the pre-agreed discard address and adds `NO_EXPORT (65535:65281)` so the blackhole does not propagate beyond the IXP.
4. All RS peers receive the route. Each peer must have a static null route to the discard address (see member Welcome Pack) to drop matching traffic at their edge.

**Why this matters for Pacific IXPs:** Pacific Island networks are frequent targets of volumetric DDoS traffic originating outside the region. RTBH allows a member to shed attack traffic at the IXP before it exhausts their uplink — it is the primary DDoS mitigation tool available to members without a dedicated scrubbing service.

> **RTBH is not a substitute for upstream filtering.** It stops inbound traffic at IXP peers but does not affect transit-sourced traffic. Members should also register with their upstream provider's RTBH community scheme.

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

*   **Internal Emergency:** `noc@PACIXP.net` / `+679-XXX-XXXX`
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
