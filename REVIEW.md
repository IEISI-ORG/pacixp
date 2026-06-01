Proxy-ARP nonsense removed from four files. `onboarding.md:66` is intentionally kept — that line addresses *member* router configuration, which is a legitimate IXP requirement (confirmed by the MANRS guide and Pacific IXP Guideline source documents in `/documents/`).

**2026-06-01 fixes:** RFC 7999 RTBH fully implemented (`labs/configs/rs1.cfg` filter functions, `docs/03-security-hardening.md` §3.3, `strategy/onboarding.md` per-vendor examples). Kernel protocol fixed to `import/export none`. Member template `import all` replaced with proper import filter. Cisco `next-hop-self` removed from RS session templates. MD5 BGP guidance updated to "not recommended." `send-community` annotated for RTBH.

Now the deep expert review. This is long and detailed — it is intended for the contributor console.

---

# PACIXP Reference Design — Deep Technical Review

**Reviewer stance:** IXP operator with multi-site EVPN/VXLAN production experience, MANRS working group familiarity, and Pacific regional IXP context.
**Scope:** Architecture, configuration templates, security model, automation strategy, operational procedures, documentation consistency.
**Not reviewed:** Physical procurement, legal agreements.

---

## 1. Architecture: What Is Working Well

**BGP Confederation for EVPN overlay — correct and well-justified.**
The decision to use confederation sub-ASes (one per site) rather than a route reflector is sound for this environment. RR failures are a single point of failure; confederation is inherently redundant and scales as O(S) sessions per switch rather than O(N²). The `next-hop-unchanged` / `no-nexthop-change` requirement is correctly identified and implemented in both vendor templates. This is the detail that most commonly breaks cross-site VXLAN in confederation deployments and the docs cover it explicitly.

**DP-1 topology mirroring principle is elegant and well-enforced.**
The 1:1 mapping of ISL → iBGP and VXLAN tunnel → confederation eBGP is a strong design principle that simplifies mental models and failure correlation. It is consistently applied across the Arista and Juniper templates.

**Dual-stack from day one (DP-10) — the right call.**
Retroactive IPv6 deployment on an operational IXP is significantly harder than doing it at Day 0. The templates correctly enforce this at every layer: OSPFv3 alongside OSPFv2, dual-AF BGP sessions, dual ACLs, dual addressing on every interface. The use of RFC9637 (`3fff::/20`) rather than the old `2001:db8::/32` for examples is current best practice.

**EVPN ARP suppression / no-multicast design is correct for WAN.**
The choice to use EVPN Type 3 ingress replication over PIM multicast is correct: many Pacific WAN providers simply drop multicast, and the operational overhead of PIM in a small team would be disproportionate. The EVPN control plane already provides a better mechanism.

**Layered filtering (IRR inner gate, RPKI outer gate) is correctly framed.**
The ordering — IRR always active, RPKI as outer gate that can fail — correctly addresses the operational reality that RPKI caches go offline and the network must not degrade catastrophically when they do. The "blast radius" framing in DP-5 is accurate and useful.

**MAC limit violation action `restrict` (not `shutdown`) — correct.**
The earlier TODO item about this was properly resolved. `shutdown` on a port-security violation means a member's port goes dark any time they reboot a router (which sends a new MAC from the same hardware), requiring a manual `no shutdown` from the NOC. `restrict` drops and alerts, keeps the port up, and the operator investigates rather than panicking. This is the standard IXP choice and the rationale is documented.

---

## 2. Architecture: Issues and Gaps

### 2.1 Critical

**RPKI fail-open in `strategy/virtualization.md` still contradicts DP-5.**
`strategy/virtualization.md:71` explicitly states: *"PACIXP Default: Fail Open (Warn)"*. DP-5 says fail-closed is mandatory. This is a direct contradiction in two normative documents. The TODO tracks this (`## Critical: RPKI Cache Expiry Policy is "Fail Open"`), but no fix has landed. On a production RS, `bird.conf` must contain something like:

```
protocol rpki routinator {
    remote 127.0.0.1 port 3323;
    retry keep 90;
    refresh keep 900;
    expire keep 172800;
}
# In the filter function, fail closed:
# if roa_check(rpki_table, net, bgp_path.last) = ROA_UNKNOWN { ... }
# If routinator is unreachable, routes should be held, not accepted.
```

BIRD does not automatically fail-closed on RTR session loss — the operator must write the filter function to treat `ROA_UNKNOWN` (which is what BIRD returns when the RTR session is down and the cache has expired) as a rejection. This requires a concrete BIRD filter snippet in the RS config and in `strategy/virtualization.md`. **This is the highest-priority unfixed item in the repo.**

**Lab RS config uses `import all` / `export all` with no filtering.**
`labs/configs/rs1.cfg` uses `import all; export all` in the member template with comments saying "In production: apply RPKI, IRR, bogon, and max-prefix filters." The lab is the proof-of-concept that engineers use to learn the system. A lab that accepts and redistributes everything teaches engineers the wrong mental model and provides no verification that the filter logic even compiles. Even a minimal bogon filter would be significantly better. The TODO item exists but is unresolved.

### 2.2 High

**Lab switches have no BGP timers — violates DP-13.**
`labs/configs/sw1.cfg` and `sw2.cfg` set no timers on any BGP neighbor. DP-13 explicitly says "Never leave timers unset." The lab switches will default to Arista's 30/90, while `rs1.cfg` uses 10/30. When an engineer tests failure scenarios in the lab, the asymmetric hold-down periods produce confusing results that don't match production expectations. The TODO item exists but is unresolved.

**Lab switch OSPF uses a broad `/24` network statement.**
`labs/configs/sw1.cfg:57`: `network 198.51.100.0/24 area 0.0.0.0` — this advertises the entire /24 into OSPF, which in the lab environment will work but is not how the production template is structured. The production Arista template correctly uses specific /32 and /26 statements. The lab teaches the wrong OSPF configuration pattern.

**`strategy/virtualization.md` places Routinator on the MGMT VM.**
The MGMT VM is shared infrastructure (IXP Manager, Oxidized, monitoring). If that VM is under load (e.g., during a cron-driven MRTG polling spike), Routinator's RTR responses to the route server may be delayed. For RPKI validation, Routinator should either be on the same server as the route server (local socket RTR, latency near zero) or at minimum a dedicated container with CPU isolation. In Pacific environments where network operators may be running all this on a single Proxmox host, latency to a shared container matters.

**IPv6 RS sessions missing from lab.**
`labs/configs/rs1.cfg` defines only IPv4 neighbor sessions. `labs/configs/peers/member1.cfg` attempts an IPv6 BGP session to `3fff:0:1::fe` that will never establish. This creates a misleading lab where the IPv6 peering path appears in config but never works. The TODO item exists but is unresolved.

**IXP Manager Docker: no TLS.**
`docs/05-ixp-manager.md` exposes port 443 but has no SSL volume or Nginx TLS config. Port 80 is also exposed with no redirect. This is listed as Critical in TODO but remains unfixed. IXP Manager contains all member data, API keys, and generates route server configs — it must not be exposed over plaintext HTTP. The Nginx container in the compose file doesn't even have a static web root configured — it mounts `ixp-storage` as a volume but there is no `nginx.conf` defining the PHP-FPM upstream, which means the default Nginx config will 404 on every request regardless of TLS.

### 2.3 Medium

**The inter-site BGP topology has a scalability gap at 4+ sites.**
The current confederation design correctly states that each switch maintains "one iBGP session plus one confederation eBGP session per remote site." But the templates show Site A SW1 peering with Site B SW1 only (`neighbor 198.51.100.21`). For a full mesh of EVPN sessions (required so all VTEPs learn each other's MAC/IP bindings), Site A SW1 must also peer with Site B SW2 for EVPN. The diagram shows SW1↔SW1 and SW2↔SW2 inter-site sessions, but EVPN requires every VTEP to have EVPN sessions to every other VTEP to exchange Type 2/3 routes. With two switches per site and four sites, that's 8 VTEPs and potentially 56 sessions (full mesh). The confederation doesn't reduce this — it only avoids route re-advertisement issues. The repo should explicitly document the required session matrix per VTEP as sites are added, not just the generic "one session per remote site" statement.

Actually, re-examining: for EVPN to work across sites, each switch needs EVPN sessions to all remote switches. In the two-site example this works with SW1↔SW1 and SW2↔SW2. But what about SW1 at Site A learning MAC/IP bindings from SW2 at Site B? That happens via iBGP within Site B (SW2 at Site B → SW1 at Site B → confederation eBGP → SW1 at Site A). The iBGP full-mesh within a site provides the intra-site propagation. So the design actually IS correct — each site needs sessions to each remote site's *elected representative* switch(es), and intra-site iBGP propagates the rest. This should be documented more explicitly to prevent confusion.

**No CoPP (Control Plane Policing) in switch templates.**
The security hardening doc mentions CoPP in section 4.2 but neither the Arista nor Juniper template includes CoPP configuration. On an IXP where members can send arbitrary traffic, a member sending a flood of SSH SYN packets to the switch management IP (if reachable) or a high rate of ARP/ICMPv6 could spike the switch CPU. CoPP is not optional at a production IXP. At minimum, the templates should include rate-limiting for ICMP, ARP (to CPU), and management traffic.

**No GTSM on RS BGP sessions.**
`docs/03-security-hardening.md:93` mentions GTSM (TTL Security) as a BGP session hardening measure. Neither the BIRD RS config nor the switch templates implement it. For BIRD, `ttl security` in the neighbor stanza enables this. For Arista: `neighbor <ip> ttl maximum-hops 1`. GTSM is low-cost and should be in the templates, not just mentioned in the security doc.

**SNMP community string `PACIXP-public` in templates.**
Both the Arista template and the runbook use `PACIXP-public` as the SNMPv2c community string. The TODO item requests a warning comment. More importantly, the document should recommend SNMPv3 with authentication and privacy (`priv`) for production, and note that SNMPv2c community strings are effectively cleartext passwords for the management interface. The current security philosophy document doesn't address this.

**`strategy/virtualization.md` still shows `mariadb:10` (unversioned image).**
The container inventory table lists `mariadb:10` without a pinned version. The `templates/ixp-manager-docker-compose.yml` has since been pinned (per the TODO resolution), but `virtualization.md:53` hasn't been updated to match. It will mislead operators who use that document as the authoritative container reference.

**OOB addressing contradiction (DP-7 vs DP-12).**
`docs/00-design-principles.md` DP-7 at line 111 references `192.168.100.0/24` for the OOB management VLAN. DP-12 prohibits RFC1918 in templates and maps OOB management to `203.0.113.0/24`. The HLD and all configs use `203.0.113.0/24`. DP-7 is wrong. The TODO item exists but is unresolved.

**HLD says "OSPFv2/OSPFv3 or eBGP" for underlay.**
`docs/01-high-level-design.md:87` says the underlay protocol is "OSPFv2/v3 or eBGP." DP-8 explicitly and deliberately chose OSPF-only. An engineer who reads the HLD first and chooses eBGP underlay will have a deployment incompatible with all runbooks, and more importantly will have a significantly more complex operational environment (per-session eBGP config vs. protocol-level OSPF). The "or eBGP" option should be removed. The TODO item exists but is unresolved.

---

## 3. Security Model: What Is Working Well

**Ethertype filtering (MANRS Action 3) — correct and complete.**
The `IXP-ETHERTYPE-FILTER` MAC ACL allows only 0x0800/0x0806/0x86DD and drops everything else. This is applied *before* IP-layer ACLs, which means IS-IS, CDP, LACP, LLDP, and all other non-IP control-plane protocols are dropped at L2 without reaching the IP filtering stack. This is the correct architecture and is consistent between Arista and Juniper implementations.

**BPDU Guard with `portfast` — correct combination.**
EOS `spanning-tree portfast` + `spanning-tree bpduguard enable` is the correct combination for IXP member ports. Portfast suppresses TCN generation on port state changes (preventing topology change notifications flooding the fabric); BPDU Guard shuts the port if a BPDU is received. The Juniper equivalent (`bpdu-block-on-edge` on edge ports) is also correct.

**RA Guard via ACL (ICMPv6 Type 134 block) — adequate but with known gaps.**
The IPv6 ACL correctly drops ICMPv6 Type 134 (Router Advertisement). The TODO item (`Investigate RA Guard and IPv6 First Hop Security`) correctly identifies that ACL-based RA blocking has gaps: fragmented RAs, RAs embedded in tunnels, and ICMPv6 Redirect (Type 137) which is also problematic on peering LANs. The ACL approach is standard practice among smaller IXPs and is acceptable at launch, but the TODO item should be escalated to High once the Critical items are resolved.

**Source IP filtering (ingress PACLs) — above and beyond MANRS.**
The note in `docs/03-security-hardening.md` that source IP PACLs are "PACIXP policy beyond the MANRS L2 baseline" is accurate. Most IXPs don't implement per-member ingress source IP ACLs due to the operational overhead of generating and maintaining them. The decision to include this is reasonable for a greenfield IXP that has automation generating member configs from IXP Manager.

**Quarantine VLAN workflow — industry standard and correctly described.**
The member onboarding pre-flight check (quarantine VLAN → optical verification → MAC check → tcpdump → production VLAN) is the standard IXP onboarding procedure and is correctly documented.

---

## 4. Security Model: Issues and Gaps

### 4.1 Critical

**RPKI fail-open (see §2.1 above)** — the most serious security issue in the repo.

### 4.2 High

**MD5 on BGP sessions described as "optional" — should be removed entirely.**
`docs/03-security-hardening.md:91` says "MD5 Passwords: Optional (adds complexity), but supported if requested." For IXP route servers, MD5 TCP authentication on BGP sessions is actually counterproductive in 2025: it creates operational overhead (password must match on both sides, must be rotated, rotation requires session teardown), is not a meaningful security control against on-path attackers (TCP MD5 can be brute-forced in reasonable time given known BGP traffic patterns), and is superseded by GTSM + the existing source IP ACLs. The current MANRS IXP Implementation Guide does not recommend MD5 for route servers. The recommendation should be: do not offer MD5 unless a member insists; if they insist, document the operational overhead. The current framing ("Optional but supported") implies it is a positive option.

**No BGP session authentication via RPKI-based mechanisms.**
The security model relies on GTSM + source IP filtering for RS session security. This is adequate. However, the documentation doesn't address what happens when a member changes their peering IP (e.g., renumbers): there is no process described for validating that the new IP came from IXP Manager versus an unauthorized update. The IXP Manager workflow (DP-3) addresses this implicitly but it should be explicit.

**BIRD RS security model is incomplete.**
The route server template (`labs/configs/rs1.cfg`) is the primary reference for production RS configuration. It has:
- `protocol kernel { import all; export all; }` — on a route server, the kernel protocol should be disabled or locked down to management routes only. A route server must NOT import from the kernel routing table (which would leak server routes into the RS) nor export BGP routes to the kernel (which would consume memory unnecessarily).
- No firewall (nftables/iptables) referenced or documented anywhere for the RS VM. The security doc mentions it should be "locked down to BGP (179) and SSH (22)" but there is no template or runbook showing this configuration.

**No CoPP in switch templates (see §2.3).**

### 4.3 Medium

**ICMPv6 Redirect (Type 137) not blocked.**
Identified in the TODO under the RA Guard investigation item. ICMPv6 Type 137 allows any host to redirect traffic from other hosts to an alternative gateway. On an IXP peering LAN, a malicious member could redirect other members' traffic through their router. This should be added to `ACL-IXP-PEERING-V6`:
```
deny icmp any any redirect
```

**uRPF described as applicable, but the ports are switchports.**
`docs/01-high-level-design.md:177` mentions "Strict uRPF or ACLs permitting only the member's assigned IP." `docs/03-security-hardening.md:88` correctly clarifies that "uRPF is not applicable — member ports are Layer 2 switchports." The HLD should be updated to remove uRPF from the L3 hardening section — it creates confusion when an engineer reads the HLD first and tries to implement uRPF on a switchport.

---

## 5. Automation & Operations: What Is Working Well

**Two-layer event detection (DP-14) — well-designed.**
The syslog → rsyslog → Oxidized API fast path combined with the hourly Oxidized polling fallback is the correct architecture. The explicit guidance about avoiding duplicate `$UDPServerRun 514` directives (a common operational mistake when LibreNMS and Oxidized both want syslog) is exactly the kind of hard-won operational knowledge that belongs in a reference design. The hostname matching caveat (SNMP sysName vs. switch `hostname`) is also well-documented.

**"Generate and Apply" switch provisioning model — appropriately conservative.**
For a small Pacific Island IXP team, deferring full NETCONF/Ansible automation until operational confidence is established is the right choice. The explicit documentation of the decision rationale (in DP-8 and the automation strategy) means a future engineer knows *why* the team chose this and can consciously upgrade when ready. This is better than a repo that just uses Ansible without explaining the risk model.

**IXP Manager as single source of truth (DP-3) — well-enforced.**
The anti-patterns section explicitly lists "Hand-edited BIRD configurations" as rejected. The automation diagram correctly shows the flow: IXP Manager DB → script → `bird.conf` → `birdc configure`. The 15-minute cron cycle is an established IXP pattern (AMS-IX, LINX, DE-CIX all use similar cycles).

---

## 6. Automation & Operations: Issues and Gaps

### 6.1 High

**No RS upgrade runbook (zero-downtime).**
The TODO item exists. There is no documented procedure for upgrading BIRD on RS1 without impacting member sessions. The correct procedure (drain RS1 by having IXP Manager set it to maintenance mode, wait for member sessions to migrate to RS2, upgrade, restore) is not documented. On a production IXP, this is a critical operational gap because RS upgrades are required periodically for BIRD security patches and feature updates.

**No IXP Manager upgrade/backup runbook.**
The compose file has version-pinned images, which is correct. But there is no documented procedure for upgrading from v6.3.0 to a future version, including database migration steps. IXP Manager uses Laravel migrations; a failed migration on a production system locks out all portal access and stops RS config generation. The risk is disproportionate without a documented tested procedure.

**DB backup exposes password in cron command line.**
`strategy/automation.md:166` uses `mysqldump -u ixp -pPASSWORD` in the example cron command. This exposes the password in `ps` output, shell history, and cron logs. The TODO item exists. The correct approach in Docker is to use either:
```bash
docker compose exec -T db sh -c 'mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE' > /backups/ixp.sql
```
or a `--defaults-extra-file` pointing to a root-only `.my.cnf`.

**`ixp-manager-bird-api` script not in repo.**
The automation doc references this script as the mechanism that generates `bird.conf` and reloads BIRD. IXP Manager actually has a built-in router configuration API (`/api/v4/router/`) and a dedicated CLI command (`artisan`). The reference to `ixp-manager-bird-api` as an external script is potentially misleading — the correct integration is to use IXP Manager's own `artisan router:gen-and-write` command (or equivalent for the pinned version). The repo should include the actual cron command or script that calls IXP Manager's router API, not a placeholder reference.

### 6.2 Medium

**Oxidized config exposes credentials in plaintext.**
`strategy/automation.md` (the Oxidized config block) shows `password: your_ssh_password` in a YAML config file. Oxidized supports reading credentials from environment variables. The template should use:
```yaml
vars:
  password: <%= ENV['OXIDIZED_PASSWORD'] %>
```
or use the `secrets` Docker Compose facility. Current config will result in passwords in the git repo if anyone commits their working oxidized config.

**LibreNMS SNMP v2c only.**
The runbook and switch templates all configure SNMPv2c. LibreNMS supports SNMPv3 natively. For a network operations platform, SNMPv3 with `authPriv` (SHA auth + AES priv) should be the documented default. The current community string `PACIXP-public` would allow any host on the management network with UDP reachability to read the entire switch MIB.

**No alerting thresholds documented.**
The TODO item (`Add alert thresholds for BGP drops/high error rates`) is unresolved. An IXP without automated alerting is effectively blind between human polling events. At minimum, the documentation should specify:
- BGP session down → alert within 5 minutes (LibreNMS BGP monitoring)
- RPKI validator unreachable → alert within polling interval
- Port error rate > N/5min → alert
- RS disk/memory thresholds

**No procedure for MAC violation response.**
The troubleshooting matrix in `strategy/onboarding.md` says "Admin: Clear port-security on switch" but doesn't specify the exact CLI command or whether clearing port-security should be done before or after verifying the member's updated MAC in IXP Manager. A missing step here means an operator under pressure will clear port-security first and verify IXP Manager second — allowing a wrong MAC to stay up.

---

## 7. Documentation Consistency: Remaining Issues

The documents are generally well-written and internally consistent. Issues found:

**1. DP-7 OOB address (`192.168.100.0/24` vs `203.0.113.0/24`) — unresolved (see TODO).**

**2. HLD underlay "or eBGP" — unresolved (see TODO).**

**3. `strategy/virtualization.md:53` shows unversioned `mariadb:10` — inconsistent with pinned compose.**

**4. Mermaid diagram in HLD is inconsistent with confederation design.**
`docs/01-high-level-design.md` mermaid diagram (lines 63-77) shows intra-site connections as `A_SW1 --- A_SW2` without the iBGP label on the ISL. More importantly, it shows `A_SW1 -. "iBGP EVPN (Sub-AS 64501)" .-> A_SW2`, but the label says "iBGP" while the session description also in the same line correctly says it's in Sub-AS 64501. Minor but the label "iBGP EVPN (Sub-AS 64501)" is confusing — it should say "iBGP EVPN (Intra-Sub-AS 64501)".

**5. HLD 5.1 security section describes `Shutdown` as preferred for MAC violations.**
`docs/01-high-level-design.md:161` says "Violation Action: Drop or Shutdown (Drop preferred)." The DP-6 and the resolved TODO both establish that `restrict` (EOS term for "drop and alert, port stays up") is the correct choice, and `shutdown` is explicitly rejected. The HLD security section hasn't been updated to reflect this decision. An engineer following the HLD rather than the design principles would implement the wrong violation action.

**6. Onboarding Cisco config uses `next-hop-self` — incorrect for RS sessions.**
`strategy/onboarding.md:84,91`: The Cisco IOS example uses `neighbor ... next-hop-self` for the IPv4 and IPv6 address families. `next-hop-self` is correct for transit providers but **wrong for IXP route server sessions**. On an IXP, members must advertise routes with their own IP as the BGP next-hop so other members can reach them directly across the peering LAN. `next-hop-self` would replace the member's peering IP with the RS's IP as next-hop, causing asymmetric routing or blackholes. This should be removed from the Cisco template entirely — it is not needed when peering with a route server.

**7. MikroTik member config is incomplete.**
The MikroTik RouterOS v7 example in `strategy/onboarding.md:103` uses `templates=PACIXP-RS` which references a BGP template that was defined separately. The template definition (`/routing bgp template add name=PACIXP-RS as=65000`) is shown, but the output-filter, input-filter, and session options are missing. MikroTik is extremely common among Pacific Island ISPs and telcos — a complete config example matters more here than for Cisco or Juniper.

---

## 8. BGP/EVPN Technical Deep Dive

### 8.1 Route Distinguisher Design

The current RD format is `<vtep-loopback>:10010` (e.g., `198.51.100.11:10010`). This is correct — each VTEP has a unique RD, preventing Type 2 routes from the same MAC/IP being treated as duplicates when received from different VTEPs. However: if VLAN 20 is ever added (future member VLAN or a second peering domain for, say, a content exchange), the VNI numbering convention (`VLAN × 1000 + VLAN`) would give VNI 20020. The RD would then need to be `198.51.100.11:20020`. The current templates hardcode `10010` everywhere; this should be documented as a template variable, not a hardcoded value.

### 8.2 Route Target Design

`route-target import/export 64500:10010` — using the confederation identifier (`64500`) in the RT rather than the sub-AS is correct. If sub-AS numbers were used, a VNI on Site A would only import routes tagged with `64501:10010`, missing routes from Site B (`64502:10010`). The documentation explains this but the implication (all VTEPs share a single VNI-to-RT mapping regardless of site) is worth stating even more explicitly in the template comments for engineers who are familiar with traditional EVPN designs where RT is per-site.

### 8.3 BUM Replication Scaling

The current design uses EVPN Type 3 (Inclusive Multicast Ethernet Tag) for ingress replication. For a 4-site fabric with 2 VTEPs per site (8 VTEPs total), each VTEP will replicate BUM to 7 others. This is O(N) per packet, which at 10G link rates with a 1% storm control ceiling means the absolute worst-case BUM load per VTEP is ~100Mbps → 7 copies = 700Mbps egress BUM. For an IXP fabric with minimal BUM (IPv6 ND, occasional ARP, rare unknown unicast), this is completely acceptable. But the documentation should explicitly state that BUM replication scales as O(N) and that this is acceptable for expected traffic volumes, so future operators understand the constraint before adding large numbers of VTEPs.

### 8.4 VTEP Source Interface

Both templates correctly use Loopback0 as the VTEP source interface. The documentation correctly identifies that OSPF must distribute Loopback IPs before VXLAN tunnels can form. One gap: neither template includes `ip ospf network point-to-point` on the Loopback interface. Without this, the Loopback /32 is advertised in OSPF as a Type-1 LSA with the host mask, which is correct but requires explicit config. More importantly, if OSPFv3 is configured, the Loopback IPv6 /128 must also be in OSPFv3 Area 0 for IPv6 VTEP addressing — this is present in the template but the documentation doesn't explain *why* this matters (IPv6 outer headers require IPv6 reachable VTEP IPs).

---

## 9. Operational Readiness Gaps Not in TODO

The following issues are not currently tracked in `TODO.md`:

**9.1 No MTU verification procedure is automated.**
DP-11 mandates a `ping <vtep-ip> size 8972 df-bit` test after each new VXLAN tunnel. This test is mentioned in the design principles but is not in any runbook. Adding a specific runbook section "Post-Build VXLAN Verification" with the exact commands for Arista and Juniper would prevent the most common IXP fabric commissioning failure.

**9.2 Routinator RTR cache is on the MGMT VM with no HA.**
If the MGMT VM fails, Routinator becomes unavailable. BIRD maintains its last RTR-downloaded ROA cache for 28,800 seconds (the `expire keep 172800` value is 48 hours). After 48 hours without Routinator, BIRD's RPKI protocol will expire and (per the correct fail-closed policy that should be in place) start rejecting all routes as RPKI_INVALID. The documentation should clarify: (a) the cache expiry window is 48 hours, (b) operators should restore MGMT within that window, (c) the monitoring system must alert when Routinator is unreachable.

**9.3 `send-community extended` is not in all RS session templates.**
For EVPN to carry extended communities (which carry the Route Target), `send-community extended` must be configured on every eBGP session that carries EVPN. The switch templates include it. The RS BIRD config does not need it explicitly (BIRD handles communities natively). But the member config templates in `strategy/onboarding.md` use `send-community` (which is standard BGP community, not extended community). Route servers typically don't need members to send communities — the RS sets communities internally. The `send-community` in the member template is likely harmless but technically unnecessary and could confuse engineers.

**9.4 No documented procedure for removing a member.**
The onboarding guide has a detailed 5-step workflow for adding a member. There is no corresponding de-provisioning workflow. Member removal requires: BGP session teardown, MAC lock removal, port shutdown, VLAN removal, IP address return to pool, IXP Manager record archival, PeeringDB update. In a Pacific Island context where a member might go bankrupt or lose their fiber connectivity for months, having a documented de-provisioning workflow prevents orphaned switch configs.

**9.5 No documented inter-site WAN provider requirements document.**
DP-11 specifies minimum 1600 bytes MTU for WAN paths. There is no formal document listing what the IXP must contractually require from WAN providers. A Pacific Island IXP will likely negotiate WAN circuits with Telecom Samoa, Vodafone Fiji, or FINTEL. Without a formal requirements document, those negotiations will be ad hoc and MTU requirements may be overlooked in the contract. This should be a one-page document under `documents/`.

**9.6 `management api http-commands` in Arista runbook enables the eAPI over HTTP.**
`runbooks/ixp-manager-arista-switch.md:43` enables the Arista eAPI with `protocol http`. This opens the REST management API over plaintext HTTP on the management interface. For a production IXP, this should be `protocol https` only. The comment says "this is needed to allow SNMP" which is incorrect — SNMP is a separate protocol entirely and does not require the eAPI to be enabled. The eAPI is only needed for Ansible/NETCONF management. If the team is not using Ansible yet (per the current "Generate and Apply" model), the eAPI should not be enabled at all.

---

## 10. Business and Policy Gaps

**10.1 No MLPA template (open in TODO, unresolved).**
Pacific Island IXPs using the Multilateral Peering Agreement model (standard for all PACNOG-affiliated IXPs) require members to sign an MLPA before connecting to route servers. Without this, the IXP has no legal standing to enforce the peering policy (RPKI, IRR requirements, no-DHCP-server, etc.). The member onboarding guide should not reach "Go Live" without MLPA signature. This is tracked in TODO.

**10.2 BGP community policy undefined (tracked in TODO, unresolved).**
The `send-community` in member configs implies the IXP processes communities. Without a defined community set, members will send communities and the RS will silently ignore them. The RTBH community (65535:666 / RFC7999) is particularly important — Pacific Island IXPs are targets for DDoS traffic from outside the region. A working RTBH implementation allows a member under attack to null-route a destination at the IXP level, protecting all exchange participants. This should be a near-term design decision, not a "medium priority" backlog item.

**10.3 No member SLAs defined.**
The TODO tracks this as Low. For grant-funded Pacific IXPs (ISOC, APNIC), demonstrating operational credibility often requires documented SLAs. A simple SLA document (port provisioning within 5 business days, BGP recovery within 30 minutes, 99.9% monthly uptime commitment) is a precondition for membership agreements with larger ISPs and government networks.

---

## 11. Summary Assessment

The PACIXP reference design is **technically well-founded** at the architecture level. The confederation EVPN design, the dual-stack enforcement, the layered IRR/RPKI filtering, and the "Generate and Apply" automation model are all correct choices for the target environment. The design principles document (`docs/00-design-principles.md`) is the strongest document in the repo — it is precise, explains rationale, and is useful as an engineering reference.

**The main remaining blockers before this could be used as a production deployment guide:**

| # | Severity | Item |
|---|---|---|
| 1 | **Critical** | RPKI fail-open contradiction in `strategy/virtualization.md` — must produce concrete BIRD filter that fails closed |
| 2 | **Critical** | ✓ FIXED: `BOGONS_V4/V6` sets, bogon + length guards, `import limit 200/100`, IRR/RPKI stubs. Kernel `import/export none`. |
| 3 | **Critical** | IXP Manager Docker has no TLS and incomplete Nginx config |
| 4 | **High** | Lab BGP timers missing from `sw1.cfg` / `sw2.cfg` |
| 5 | **High** | No RS VM firewall template (nftables/iptables) |
| 6 | **High** | No zero-downtime RS or IXP Manager upgrade runbook |
| 7 | **High** | ✓ FIXED: Cisco `next-hop-self` removed from RS session templates |
| 8 | **High** | eAPI enabled over HTTP in Arista runbook |
| 9 | **Medium** | ICMPv6 Redirect (Type 137) not blocked in IPv6 ACL |
| 10 | **Medium** | HLD MAC violation action not updated to `restrict` |
| 11 | **Medium** | No MLPA template |
| 12 | **Medium** | No member de-provisioning workflow |
| 13 | **Medium** | DB backup password exposure in cron command |
| 14 | **Medium** | ✓ FIXED: RFC 7999 RTBH (`65535:666`) fully implemented |
| 15 | **Low** | DP-7 OOB addressing RFC1918 contradiction |
| 16 | **Low** | HLD "or eBGP" in underlay section |
| 17 | **Low** | `virtualization.md` unversioned MariaDB image reference |
| 18 | **Low** | IPv6 RS sessions missing from lab |
| 19 | **Low** | Post-build MTU verification runbook missing |

The design is production-deployable for an expert team who can fill the gaps from experience. It is not yet safe as a turnkey reference for the stated target audience (a small Pacific island NOC team with limited IXP experience) — primarily because of items 1, 2, 7, and 8.

---

*Review complete. The Proxy-ARP items have been removed from `TODO.md`, `docs/00-design-principles.md`, `docs/03-security-hardening.md`, and `README.md`. The mention in `strategy/onboarding.md:66` (member welcome pack requirement: "No Proxy ARP") has been intentionally preserved — it is a valid requirement directed at member router configuration, not at the IXP switch, and is consistent with the MANRS IXP Implementation Guide, the Pacific IXP Operating Guideline, and the Global IXP Toolkit, all of which are present in `/documents/`.*
