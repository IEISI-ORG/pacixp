# PACIXP Design Principles

| Document Details | |
| :--- | :--- |
| **Project** | Pacific Islands Internet Exchange (PACIXP) |
| **Status** | Normative — review before any architectural change |
| **Purpose** | Govern all design decisions across the fabric, configs, and operations |

This document is the authoritative statement of *why* PACIXP is built the way it is. Every significant change to the architecture, configuration templates, or operational procedures should be evaluated against these principles before being accepted. When a proposed change conflicts with a principle, the conflict must be explicitly acknowledged and resolved — either by rejecting the change or by updating this document with a documented rationale.

---

## 1. Governing Principles

### DP-1 — Mirror the Physical Topology

> **The BGP control plane topology must be a 1:1 logical mirror of the physical data plane topology.**

- An intra-site Inter-Switch Link (ISL) corresponds to an intra-site iBGP session.
- An inter-site VXLAN tunnel corresponds to an inter-site confederation eBGP session.
- No BGP session should exist where there is no corresponding physical (or logical) forwarding path.

*Why:* When the control plane and data plane topologies are identical, a single mental model covers both. Failures are immediately obvious — a link going down takes down its mirror BGP session. There are no "phantom" BGP paths that route traffic over hops the operator isn't expecting.

---

### DP-2 — Dynamic over Static

> **Configuration that must be manually updated as the network grows is a defect, not a limitation.**

- VTEP discovery uses EVPN Type 3 routes. Static VTEP flood lists are prohibited.
- BGP peering tables are generated from IXP Manager. Hand-coded prefix filters are prohibited.
- Route Server configurations are regenerated every 15 minutes from the source of truth.

*Why:* Static lists become incorrect the moment the network changes. In a geographically distributed IXP where sites are added infrequently by a small team, a stale static entry will not be caught for months. The correct fix is to make the configuration self-maintaining.

---

### DP-3 — IXP Manager is the Single Source of Truth

> **"If it isn't in IXP Manager, it doesn't exist."**

- Member IP allocations, AS numbers, MAC addresses, and port assignments live only in IXP Manager.
- No parallel spreadsheets, no local text files on the route servers, no hand-edited BIRD configs.
- Switch port configurations are generated from IXP Manager templates. Engineers apply them; they do not author them.

*Why:* Dual-tracking data leads to drift. When the DB and the switch disagree, debugging becomes archaeology. Centralizing data ensures that any tool consuming that data (BIRD, Oxidized, looking glass, PeeringDB export) is always consistent.

---

### DP-4 — Local Survivability

> **A WAN link failure must not degrade peering within a site.**

- The EVPN data plane is independent of the EVPN control plane. Existing MAC/IP forwarding entries survive a BGP session drop for the hold-down period.
- The Route Servers operate independently of IXP Manager. If the management plane is offline, BGP sessions remain established.
- When an inter-site VXLAN tunnel drops, EVPN routes for remote VTEPs withdraw. Members at the local site continue peering with each other without interruption.

*Why:* IXPs in the Pacific Islands depend on submarine cables that are subject to cuts and outages. An IXP that stops working when an international link is cut provides negative value — it would have been better for members to route directly via transit.

---

### DP-5 — Fail Closed, with IRR as the Inner Defence Layer

> **When validation state is unknown, the safe default is to reject, not to accept. Route filtering uses two independent layers — IRR and RPKI — and both must be active. The IRR layer operates regardless of RPKI state and provides meaningful protection during RPKI cache outages.**

**The two filter layers and what each catches:**

| Layer | Mechanism | What it rejects | Operates when RPKI is down? |
| :--- | :--- | :--- | :--- |
| **IRR prefix filter** | `bgpq4` expands member AS-SET → prefix-list applied as inbound filter on RS | Any prefix outside the member's declared routing policy | **Yes — always active** |
| **RPKI ROV** | BIRD queries local Routinator; drops `RPKI_INVALID` routes | Routes where the announcing AS has no valid ROA for the prefix | No — depends on validator reachability |

**Rules:**
- RPKI validation: routes with `RPKI_INVALID` origin are dropped unconditionally. Routes with `RPKI_UNKNOWN` are accepted only during the initial deployment phase; the goal is full ROV enforcement.
- RPKI cache expiry: route servers must reject or hold routes rather than accepting them as valid. IRR filters remain active throughout and limit the blast radius to prefixes within the member's own AS-SET.
- IRR filter hygiene: members must register an accurate AS-SET in a public IRR (RADB, RIPE, or APNIC) as a condition of membership. Stale or overly broad AS-SETs directly reduce the protection this layer provides.
- IRR filters are refreshed every 15 minutes via IXP Manager. A member who adds a new prefix to their AS-SET will have it accepted within one refresh cycle — no manual RS intervention required.
- BGP session limits: if a member exceeds their configured max-prefix limit, the session is torn down immediately.

**Residual risk during RPKI cache expiry:** IRR filters do not catch a route where the prefix *is* within the member's AS-SET but the origin AS has an `RPKI_INVALID` ROA (e.g., a hijack by a member of their own prefix from a different AS). This is the attack surface that remains when RPKI is unavailable. Tight AS-SETs minimise this window; RPKI fail-closed eliminates it.

*Why:* An IXP that passes invalid routes, even briefly, actively harms the global routing table. The layered approach ensures that a temporary RPKI validator outage degrades security incrementally rather than catastrophically — the IRR layer continues to reject out-of-policy routes while RPKI is restored.

---

### DP-6 — Protect the Fabric from Its Members

> **No single member must be able to degrade the exchange for others.**

The following controls are non-negotiable on every member-facing port and are never removed for a specific member:

| Control | Mechanism | Why |
| :--- | :--- | :--- |
| MAC limit | Port security: max 1 MAC, drop on violation | Prevents MAC table exhaustion and bridging loops |
| Storm control | Broadcast + multicast ≤ 1% of link | Prevents BUM floods from saturating the fabric |
| BPDU guard | Drop STP BPDUs; shut port on receipt | Prevents a member's switch from manipulating the spanning tree |
| RA guard | Drop ICMPv6 Type 134 | Prevents a member from becoming the IPv6 default gateway for the IXP |
| DHCP guard | Drop UDP 67/68 and 546/547 | Prevents rogue DHCP/DHCPv6 servers |
| IGP filtering | Drop OSPF/IS-IS/EIGRP | Prevents IGP adjacency formation across the peering LAN |
| LLDP disabled | No transmit/receive on member ports | Prevents topology information leakage |

Exceptions require written justification and must not weaken protection for other members.

---

### DP-7 — Management Plane is Physically Isolated

> **The control plane and management plane must never share a path with the data plane.**

- All switches and servers have dedicated management interfaces on a separate OOB VLAN (VLAN 99 / `192.168.100.0/24`).
- SSH, SNMP, and sFlow traffic use the management VRF. They never traverse the peering VLAN.
- Route Servers are reachable on the peering LAN only for member BGP sessions. All administrative access is via the management network.
- Console servers provide out-of-band recovery access that is independent of all IP networking.

*Why:* If the peering LAN has a problem (storm, misbehaving member, MAC flood), engineers must still be able to log in and fix it. A management path that shares the broken network with the problem is not a management path.

---

### DP-8 — Prefer Proven Simplicity over Clever Complexity

> **Choose the simplest design that meets all requirements. Add complexity only when simplicity demonstrably fails.**

- OSPF (not BGP) for the underlay. It converges predictably, requires no per-session configuration, and every engineer understands it.
- Collapsed core (2 switches per site), not a leaf-spine fabric. A single pair of high-capacity switches is operationally simpler and sufficient for the traffic volumes of a regional IXP.
- BGP confederation for the EVPN overlay. It uses standard BGP features, has no single-point-of-failure (unlike a route reflector), and scales as O(sites) not O(switches).
- Human-applied switch configuration changes (generate-and-apply, not full push automation) until the team's confidence in automation is established.

*Why:* Pacific Island IXPs are operated by small teams, often alongside other responsibilities. A design that requires deep specialist knowledge to troubleshoot at 2am during a cable cut will fail operationally. The value of simplicity compounds over time.

---

### DP-9 — MANRS Compliance is Mandatory

> **All routing security actions defined by MANRS for IXPs are implemented, not aspirational.**

The four MANRS IXP actions are treated as hard requirements:

1. **Prevent routing of IP packets with spoofed source addresses** — uRPF and ingress ACLs on all member ports.
2. **Facilitate global operational communication** — PeeringDB records are kept current; IXP Manager exports to IX-F.
3. **Facilitate validation of routing information** — RPKI ROV enforced on route servers; IRR filtering mandatory.
4. **Promote MANRS participation** — Member onboarding includes MANRS guidance; participation is tracked.

*Why:* The Pacific Islands are in a region with limited routing diversity and high dependency on a small number of submarine cables. Routing incidents have disproportionate impact. The IXP must not amplify them.

---

### DP-10 — Dual-Stack by Design

> **IPv4 and IPv6 peering must be supported with parity from the first member session. IPv4-only configurations are not acceptable at any layer.**

- **Underlay:** OSPFv2 carries IPv4 Loopback/P-P reachability; OSPFv3 carries IPv6 equivalents. Both must be configured and verified before the first VXLAN tunnel is brought up.
- **Overlay:** MP-BGP EVPN carries both IPv4 and IPv6 MAC/IP bindings (EVPN Type 2). Members receive both an IPv4 `/32` from `192.0.2.0/24` and an IPv6 `/128` from `3fff:0:1::/64` on the peering LAN.
- **Route Servers:** Each member session has two address families activated — `ipv4` and `ipv6`. A member that only supports IPv4 still establishes both; the IPv6 AF is simply empty.
- **ACLs:** `ACL-IXP-PEERING-V4` and `ACL-IXP-PEERING-V6` are both applied to every member port. The IPv6 ACL is not optional even if the member has not yet enabled IPv6.
- **Config templates:** Every configuration template in this repository shows both address families. Any template that only shows IPv4 is incomplete.

*Why:* Deploying IPv6 retroactively on an operational IXP requires touching every member config and every switch ACL simultaneously. Doing it from day one costs almost nothing. Deferring it costs months of coordination with live members.

---

### DP-11 — MTU Must be Explicit and Sufficient

> **MTU must be set explicitly on all infrastructure interfaces. The VXLAN service must not be activated until end-to-end MTU has been confirmed.**

**VXLAN overhead:**

| Outer header | Overhead |
| :--- | :--- |
| Ethernet (outer) | 14 bytes |
| IPv4 (outer) | 20 bytes |
| IPv6 (outer) | 40 bytes |
| UDP | 8 bytes |
| VXLAN | 8 bytes |
| **Total (IPv4 transport)** | **50 bytes** |
| **Total (IPv6 transport)** | **70 bytes** |

**MTU rules:**
- Physical and ISL interfaces: configure `mtu 9214` (Arista) / `mtu 9216` (Juniper). This must appear explicitly in the config, not be assumed as a default.
- WAN provider paths: must support ≥ 1600 bytes. This is the absolute minimum to carry a standard 1500-byte inner Ethernet frame over a VXLAN-over-IPv6 path (1500 + 70 = 1570, with buffer). Confirm with the provider before ordering the circuit.
- Member-facing ports: member devices use standard 1500-byte MTU. VXLAN encapsulation is transparent — they never see the outer header.
- MTU mismatch signature: tunnels form, small pings succeed, large pings or bulk transfers silently fail. Always test with `ping <vtep-ip> size 8972 df-bit` (Arista) after bringing up a new tunnel.
- MTU must be confirmed in both directions independently; a WAN provider may have asymmetric path MTU.

*Why:* Silent MTU failures are among the hardest IXP problems to diagnose. A tunnel that forms but black-holes large frames will show as intermittent application failures for affected members — the BGP session is up, pings work, but real traffic drops. Explicit MTU config and a mandatory post-build test catches this before the first member connects.

---

### DP-12 — All Examples Use IANA Documentation Addresses; Deployment Requires Real Allocations

> **Every IP address in a template, example, or diagram in this repository uses IANA-designated documentation ranges. These ranges are globally unroutable. A live IXP cannot use them. Before connecting the first member, every documentation address must be replaced with resources formally allocated by a Regional Internet Registry (RIR) or National Internet Registry (NIR).**

#### Pre-Deployment: Required RIR/NIR Allocations

For Pacific Island IXPs, the relevant RIR is **APNIC** (apnic.net). Some economies in the region have NIRs that handle allocations on APNIC's behalf — check with APNIC for the current status of your economy.

| Resource | What to request | Notes |
| :--- | :--- | :--- |
| **Public ASN** | One ASN for the BGP confederation identifier | Members and route servers peer using this ASN. Apply to APNIC or local NIR. |
| **IPv4 IXP prefix** | At minimum a `/24` | Provides 254 usable member peering addresses. Request as Provider Independent (PI) space. |
| **IPv6 IXP prefix** | At minimum a `/48` | Carve a `/64` from this for the peering LAN; reserve the rest for infrastructure and future VLANs. |

Sub-ASes used for BGP confederation members (one per site) do **not** require RIR allocation — use the 2-byte private ASN range `64512–65534` or the 4-byte private range `4200000000–4294967294`.

#### Address Replacement Map

| Example range (this repo) | Standard | Replace with in production |
| :--- | :--- | :--- |
| `192.0.2.0/24` | RFC5737 TEST-NET-1 | APNIC-allocated IXP peering LAN IPv4 prefix |
| `3fff:0:1::/64` | RFC9637 | Carved from APNIC-allocated IXP IPv6 prefix |
| `198.51.100.0/24` | RFC5737 TEST-NET-2 | RFC1918 (e.g. `10.0.0.0/8`) is acceptable for infrastructure (loopbacks, P-P links) as these are never externally reachable; alternatively use a sub-range of the IXP allocation |
| `203.0.113.0/24` | RFC5737 TEST-NET-3 | RFC1918 (e.g. `192.168.0.0/16`) is standard for OOB management networks |
| `3fff:0:2::/64`, `3fff:0:3::/64` | RFC9637 | ULA (`fd00::/8`) or carved from APNIC IPv6 allocation |
| `64500` (confederation identifier) | — | Allocated public ASN |
| `64501`–`64504` (sub-ASes) | — | Private range: `64512–65534` or `4200000000–4294967294` |

#### Prohibited in examples

| Range | Standard | Why prohibited |
| :--- | :--- | :--- |
| `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16` | RFC1918 | Could be mistaken for an operator's real private addresses and deployed without change |
| `fd00::/8` (ULA) | RFC4193 | Same risk as RFC1918; also conflicts with operator-chosen ULA prefixes |
| `2001:db8::/32` | RFC3849 | Superseded by the larger RFC9637 `3fff::/20` block for new documentation |
| Real addresses (e.g., `1.1.1.1`) | — | Must never appear in a template |

*Why:* Documentation ranges are globally unroutable and unambiguously reserved for examples. An operator who deploys a template without replacing these addresses will have a non-functional IXP — member BGP sessions will not form because the peering LAN addresses are unreachable from the global internet. RFC1918 and ULA are intentionally permitted in production for infrastructure and management, where external reachability is neither needed nor wanted. They are prohibited only in this repository's examples, where they risk being copied unchanged into a production config and overlapping with the operator's existing internal addressing.

---

### DP-13 — BGP Timers Must be Explicit and Tuned for the Path

> **BGP keepalive and hold timers must be set explicitly on every session. Vendor defaults vary between platforms and are poorly suited to inter-island WAN paths.**

**Standard timer values for this deployment:**

| Session type | Keepalive | Hold | Rationale |
| :--- | :--- | :--- | :--- |
| Intra-site iBGP (SW1 ↔ SW2) | 10 s | 30 s | Local path; fast failure detection is safe |
| Inter-site conf-eBGP (site ↔ site) | 10 s | 30 s | Default; increase if WAN is causing flapping |
| Member ↔ Route Server | 10 s | 30 s | Same-site; consistent with fabric timers |

**Rules:**
- `hold time` must be ≥ 3 × `keepalive` (RFC 4271 hard requirement).
- If an inter-site WAN path experiences chronic packet loss or jitter resulting in session flapping, increase the inter-site timers to keepalive 30 s / hold 90 s. Document the deviation per-site.
- Never leave timers unset. Vendor defaults are: Arista keepalive 30 / hold 90, Juniper keepalive 30 / hold 90, BIRD keepalive 60 / hold 240. A mixed-vendor deployment with unset timers will negotiate inconsistent hold times at session establishment, making failure behaviour unpredictable.
- BFD (Bidirectional Forwarding Detection) may be added on intra-site sessions for sub-second failure detection. Do not enable BFD on inter-island WAN sessions — BFD's rapid hello intervals amplify the effect of WAN jitter and can cause BFD to flap independently of BGP.

*Why:* A submarine cable cut that takes 90–240 seconds to be detected by BGP means VXLAN traffic to the remote site is silently black-holed for that window. Members see it as intermittent loss with no BGP alarm. Explicit 10 s / 30 s timers reduce this to 30 seconds — still not instant, but within the operational tolerance of an IXP. Leaving timers at vendor defaults also creates hidden differences between Arista and Juniper switches in a mixed-vendor fabric, making session negotiation logs harder to read.

---

## 2. Architecture Decisions

These are the specific choices that implement the governing principles. They are decisions, not suggestions.

### BGP Confederation for EVPN Overlay

**Decision:** Each physical site is a BGP confederation sub-AS. The confederation identifier is `64500`.

| Site | Sub-AS |
| :--- | :--- |
| Site A — Samoa | `64501` |
| Site B — Fiji | `64502` |
| Site C — Tonga | `64503` |
| Site D — Vanuatu | `64504` |

**Rules:**
- Route Targets and Route Distinguishers always reference the confederation identifier (`64500`), not the sub-AS.
- Intra-site sessions (SW1 ↔ SW2 at the same site): `remote-as <same sub-AS>` — iBGP behavior.
- Inter-site sessions: `remote-as <remote sub-AS>` — confederation eBGP behavior.
- `next-hop-unchanged` (Arista) / `no-nexthop-change` (Juniper) is mandatory on all inter-site EVPN sessions to preserve VTEP Loopback IPs across the confederation boundary.
- When a new site is added: add its sub-AS to the `bgp confederation peers` list on existing switches. No other change is required on existing devices.

---

### VXLAN with EVPN Control Plane (No Multicast)

**Decision:** VXLAN encapsulation; EVPN Type 3 routes for BUM replication; no PIM multicast.

**Rules:**
- Static VTEP flood lists are prohibited. EVPN Type 3 routes handle BUM replication.
- Underlay MTU must support VXLAN overhead: ≥ 9000 bytes on all infrastructure links, ≥ 1600 bytes minimum on WAN paths.
- VNI assignment: VLAN ID × 1000 + VLAN ID. VLAN 10 = VNI 10010.

---

### OSPF Underlay

**Decision:** OSPFv2/v3 distributes Loopback (VTEP) IPs across the fabric. P-P links use /31 (IPv4) and /127 (IPv6).

**Rules:**
- All P-P and Loopback interfaces are in OSPF Area 0.
- All other interfaces (member ports, management) are passive.
- No redistribution of external routes into OSPF.

---

### Route Servers

**Decision:** Two active-active BIRD 2.x route servers per site. RS1 connects to SW1; RS2 connects to SW2.

**Rules:**
- Both route servers advertise to and receive from all members.
- Route server configurations are generated by IXP Manager and must never be hand-edited.
- All four MANRS filters (RPKI, IRR, bogons, max-prefix) are applied on all sessions.
- Route servers must not export a full routing table — they are transparent RS mode only.

---

## 3. Anti-Patterns

The following patterns have been explicitly considered and rejected. Do not reintroduce them.

| Anti-Pattern | Rejected Because |
| :--- | :--- |
| Flat iBGP full-mesh across all switches | O(n²) sessions; adding a site requires touching every existing switch |
| Route Reflector for EVPN overlay | Single point of failure; confederation provides equivalent scaling without SPF risk |
| Static VTEP flood lists | Must be manually updated on every switch when a site is added or removed |
| PIM multicast for BUM replication | WAN providers in the Pacific often drop multicast; adds operational complexity for no benefit |
| Management access via peering VLAN IP | Creates dependency on a potentially broken network for fault recovery |
| Hand-edited BIRD configurations | Creates untracked state; diverges from IXP Manager data within hours |
| Automation that pushes directly to switches | Too risky for a small team; a bug in the automation can take down the fabric |
| RPKI fail-open on cache expiry | Silently accepts invalids; defeats the purpose of RPKI validation |
| Spanning Tree on the peering fabric | VXLAN eliminates L2 loops; STP adds convergence delay and topology instability risk |
| IPv4-only configuration ("add IPv6 later") | Retroactive dual-stack requires simultaneous changes to every member config and every switch ACL |
| Implicit MTU (relying on platform defaults) | Default MTU varies by platform and software version; an undocumented assumption silently breaks VXLAN |
| RFC1918 or ULA addresses in templates | Cannot be distinguished from real operator addresses; risk of being deployed unchanged |
| `2001:db8::/32` for new IPv6 examples | Superseded by RFC9637 `3fff::/20`; the older /32 is too small for realistic multi-site examples |

---

## 4. Change Evaluation Checklist

Before merging any change to architecture, configuration templates, or operational procedures, confirm:

**Topology**
- [ ] Does this change preserve the P1 mirror between physical topology and BGP session topology?
- [ ] Does this change introduce any static list that will need manual updates as sites are added?
- [ ] Does this change create or worsen a single point of failure?
- [ ] Does this change preserve local survivability (DP-4) on WAN link failure?

**Security**
- [ ] Does this change weaken any control in the P6 member-facing port checklist?
- [ ] Does this change introduce a fail-open behavior (violating DP-5)?
- [ ] Does this change route management traffic over the peering plane (violating DP-7)?
- [ ] Is MANRS compliance (DP-9) maintained?

**Operations**
- [ ] Is the change driven by a record in IXP Manager, or does it require parallel data sources (violating DP-3)?
- [ ] Has the change been validated in the Containerlab lab environment before documenting it as a template?
- [ ] If this change must be applied to every switch, is that scope clearly communicated and is the blast radius acceptable?
- [ ] Does this change increase the specialist knowledge required to operate or troubleshoot the IXP at 2am (violating DP-8)?

**BGP Timers**
- [ ] Are keepalive and hold timers explicitly set on every new or modified BGP session (no unset timers)?
- [ ] Are inter-site WAN sessions using keepalive 10 / hold 30, or is a deviation documented with justification?
- [ ] Does `hold time` = 3 × `keepalive` (RFC 4271)?

**Dual-Stack**
- [ ] Does the change apply equally to IPv4 and IPv6? If not, what is the explicit justification for the asymmetry?
- [ ] Are both `ACL-IXP-PEERING-V4` and `ACL-IXP-PEERING-V6` present and applied on all affected member ports?
- [ ] Are both IPv4 and IPv6 address families configured on all affected BGP sessions?

**MTU**
- [ ] Are all affected infrastructure interfaces (P-P, ISL, uplinks) explicitly configured with `mtu 9214`/`mtu 9216`?
- [ ] Has end-to-end path MTU been confirmed for any new or changed WAN path (minimum 1600 bytes)?
- [ ] Does the post-build test plan include a large-frame ping (`size 8972 df-bit`) across every new VXLAN tunnel?

**Addressing**
- [ ] Do all new IP address examples use RFC5737 (IPv4) or RFC9637 (IPv6) documentation ranges?
- [ ] Are there any RFC1918, ULA, or real addresses introduced? If so, remove them.

**Documentation**
- [ ] Are the relevant configuration templates (`configs/switches/`) updated?
- [ ] Is the HLD (`docs/01-high-level-design.md`) consistent with the change?
- [ ] Is `TODO.md` updated to reflect any work completed or newly identified?
- [ ] Is this document (`docs/00-design-principles.md`) still accurate, or does it need updating?
