# PACIXP Implementation Plan

Source: recommendations in `REVIEW.md` (deep technical review) cross-referenced with `TODO.md`.  
Scope: all 19 summary items plus additional findings in §§4–9.  
Not included: physical procurement, legal agreements (MLPA is tracked but content is out of scope for engineering).

---

## How to Read This Plan

Each item lists:
- **File(s):** exact paths to touch
- **Change:** what must be done
- **Effort:** S (< 30 min), M (30 min – 2 h), L (> 2 h)
- **Review ref:** section in `REVIEW.md`

Items within each phase are ordered by dependency (upstream changes first).

---

## Phase 1 — Critical Fixes (blocking production deployment)

These three items are the difference between a "reference guide" and a guide that teaches incorrect or dangerous behaviour.

### 1.1 RPKI Fail-Closed — `strategy/virtualization.md` + `labs/configs/rs1.cfg`

**File(s):**
- `strategy/virtualization.md` line 71
- `labs/configs/rs1.cfg` (kernel protocol + RPKI filter function)

**Change:**
1. In `strategy/virtualization.md:71`, replace "Fail Open (Warn)" with "Fail Closed" and add prose explaining the expiry window (48 h cache → operator must restore MGMT before then).
2. ~~In `labs/configs/rs1.cfg`, replace the bare `import all` in the kernel protocol with `import none; export none` — route servers must not import from or export to the kernel table.~~ ✓ Done 2026-06-01
3. Add a concrete BIRD filter function that rejects `ROA_UNKNOWN` when the RTR session is down (i.e., treats expired/unavailable RPKI cache as fail-closed). Include inline comment explaining that BIRD does NOT automatically fail-closed on RTR session loss.

**Effort:** M  
**Review ref:** §2.1, §4.1

---

### 1.2 Lab RS Bogon Filter Skeleton — `labs/configs/rs1.cfg`

**File(s):**
- `labs/configs/rs1.cfg`

**Change:**
Replace the `import all; export all` member template with a skeleton that includes:
- A bogon prefix filter (reject RFC1918, 0.0.0.0/8, 240.0.0.0/4, etc.)
- A max-prefix guard (reject if > 200 IPv4 or > 100 IPv6 prefixes)
- A comment block showing where RPKI and IRR checks would be inserted in production

The lab does not need a full IRR chain, but it must not teach `import all` as the operating pattern.

**Effort:** M  
**Review ref:** §2.1 (lab RS import all)  
**Status:** ✓ Completed 2026-06-01 — `BOGONS_V4`/`BOGONS_V6` prefix sets, `bogon_filter_v4/v6()` functions, `/8–/24` and `/16–/48` length guards, `import limit 200/100 action block`, IRR/RPKI gate stubs. RFC5737/RFC9637 lab ranges omitted from bogon sets with explicit comments.

---

### 1.3 IXP Manager TLS — `templates/ixp-manager-docker-compose.yml` + `docs/05-ixp-manager.md`

**File(s):**
- `templates/ixp-manager-docker-compose.yml`
- `docs/05-ixp-manager.md`

**Change:**
1. Add an `nginx.conf` snippet (or a mounted config template) to the Nginx container that:
   - Defines the PHP-FPM upstream correctly (so requests don't 404 by default)
   - Forces HTTP → HTTPS redirect on port 80
   - Terminates TLS on port 443 using a certificate volume
2. Add a `certbot` service or document the manual certificate placement path (for Pacific environments where ACME may not be available, document a self-signed cert path with a warning).
3. Update `docs/05-ixp-manager.md` to replace `http://` examples with `https://`, add TLS setup section, and remove the port-80-no-redirect configuration.

**Effort:** M  
**Review ref:** §2.2 (IXP Manager Docker: no TLS)

---

## Phase 2 — High Priority Fixes (operational gaps)

### 2.1 Quick Wins (effort S each — batch these in one session)

#### 2.1a Lab BGP Timers — `labs/configs/sw1.cfg`, `labs/configs/sw2.cfg`

**File(s):** `labs/configs/sw1.cfg`, `labs/configs/sw2.cfg`  
**Change:** Add `neighbor <ip> timers 10 30` to every BGP neighbor in both files, matching the timers already set in `rs1.cfg`. DP-13 prohibits leaving timers unset.  
**Effort:** S  
**Review ref:** §2.2 (lab switches no BGP timers)

#### 2.1b Cisco `next-hop-self` Removal — `strategy/onboarding.md`

**File(s):** `strategy/onboarding.md` lines 84, 91  
**Change:** Remove `neighbor ... next-hop-self` from both the IPv4 and IPv6 Cisco IOS address-family examples. Add a brief comment explaining that `next-hop-self` is wrong for RS sessions — members must advertise their own peering IP as next-hop. This is the only change to the Cisco template needed.  
**Effort:** S  
**Review ref:** §7 item 6  
**Status:** ✓ Completed 2026-06-01

#### 2.1c Arista eAPI HTTP → HTTPS — `runbooks/ixp-manager-arista-switch.md`

**File(s):** `runbooks/ixp-manager-arista-switch.md` line 43  
**Change:** Change `protocol http` to `protocol https`. Fix the incorrect comment that claims eAPI is needed for SNMP (SNMP is a separate protocol; eAPI is only needed for Ansible/NETCONF). Add a note that if the team is not yet using Ansible ("Generate and Apply" model), eAPI should remain disabled entirely.  
**Effort:** S  
**Review ref:** §9.6

#### 2.1d MD5 BGP Framing — `docs/03-security-hardening.md`

**File(s):** `docs/03-security-hardening.md` line 91  
**Change:** Replace "Optional (adds complexity), but supported if requested" with a clear recommendation: do not offer MD5 on RS sessions. It provides no meaningful protection against on-path attackers in 2025, creates operational overhead on rotation, and is superseded by GTSM + source IP ACLs already in place. If a member insists, document the overhead. Reference current MANRS IXP guide position.  
**Effort:** S  
**Review ref:** §4.2  
**Status:** ✓ Completed 2026-06-01

#### 2.1e `virtualization.md` Unversioned MariaDB — `strategy/virtualization.md`

**File(s):** `strategy/virtualization.md` line 53  
**Change:** Update the container inventory table entry for MariaDB from `mariadb:10` to `mariadb:10.11` (or the pinned tag used in `templates/ixp-manager-docker-compose.yml`). These two must match.  
**Effort:** S  
**Review ref:** §2.3

#### 2.1f DP-7 OOB Address Contradiction — `docs/00-design-principles.md`

**File(s):** `docs/00-design-principles.md` line 111  
**Change:** Replace `192.168.100.0/24` with `203.0.113.0/24` in DP-7. Add a cross-reference to DP-12 (no RFC1918 in templates).  
**Effort:** S  
**Review ref:** §2.3, §7 item 1

#### 2.1g HLD Underlay "or eBGP" Removal — `docs/01-high-level-design.md`

**File(s):** `docs/01-high-level-design.md` line 87  
**Change:** Remove "or eBGP" from the underlay protocol description. Add "See DP-8 for the rationale behind the OSPF-only decision." An engineer who reads the HLD and chooses eBGP will produce a deployment incompatible with all runbooks.  
**Effort:** S  
**Review ref:** §2.3, §7 item 2

#### 2.1h HLD MAC Violation Action — `docs/01-high-level-design.md`

**File(s):** `docs/01-high-level-design.md` line 161  
**Change:** Replace "Violation Action: Drop or Shutdown (Drop preferred)" with "Violation Action: `restrict` — port stays up, syslog/SNMP trap fires. See DP-6." This must match the already-resolved DP-6 decision and the Arista/Juniper templates.  
**Effort:** S  
**Review ref:** §7 item 5

#### 2.1i HLD uRPF Clarification — `docs/01-high-level-design.md`

**File(s):** `docs/01-high-level-design.md` line 177  
**Change:** Remove uRPF from the L3 hardening section. Add "Member ports are Layer 2 switchports; uRPF is not applicable. Source IP validation is provided by ingress PACLs (see `docs/03-security-hardening.md`)."  
**Effort:** S  
**Review ref:** §4.3

#### 2.1j DB Backup Password Exposure — `strategy/automation.md`

**File(s):** `strategy/automation.md` line 166  
**Change:** Replace `mysqldump -u ixp -pPASSWORD` with the Docker-native form that reads credentials from the environment:
```bash
docker compose exec -T db sh -c \
  'mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE' \
  > /backups/ixp-$(date +%Y%m%d-%H%M%S).sql
```
Add a note about using `--defaults-extra-file` as the alternative for non-Docker environments.  
**Effort:** S  
**Review ref:** §6.1

#### 2.1k Oxidized Credentials Plaintext — `strategy/automation.md`

**File(s):** `strategy/automation.md` (Oxidized config block)  
**Change:** Replace `password: your_ssh_password` with the ERB environment variable form:
```yaml
vars:
  password: <%= ENV['OXIDIZED_PASSWORD'] %>
```
Add a note pointing to Docker Compose `secrets` as the preferred injection mechanism.  
**Effort:** S  
**Review ref:** §6.2

#### 2.1l ICMPv6 Redirect Blocking — `configs/switches/arista_sw1.md`, `configs/switches/juniper_sw1.md`

**File(s):** `configs/switches/arista_sw1.md`, `configs/switches/juniper_sw1.md`  
**Change:** Add `deny icmpv6 any any redirect` (ICMPv6 Type 137) to `ACL-IXP-PEERING-V6` in both switch templates. A malicious member can use ICMPv6 Redirect to divert other members' traffic. Add a comment referencing RFC 6104 (Rogue IPv6 Router Advertisement Problem Statement).  
**Effort:** S  
**Review ref:** §4.3

#### 2.1m SNMP Community String Warning — `configs/switches/arista_sw1.md`

**File(s):** `configs/switches/arista_sw1.md`  
**Change:** Add a prominent inline warning comment at the line defining `PACIXP-public`. Note that SNMPv2c community strings are cleartext passwords, and recommend SNMPv3 `authPriv` (SHA auth + AES priv) for production. Add the same guidance to `docs/03-security-hardening.md`.  
**Effort:** S  
**Review ref:** §2.3

---

### 2.2 Medium Effort

#### 2.2a RS VM Firewall Template (new file)

**File(s):** `runbooks/rs-vm-hardening.md` (new)  
**Change:** Create a new runbook documenting the nftables/iptables configuration for the RS VM. It must:
- Allow only BGP (TCP 179) from IXP peering LAN prefixes
- Allow SSH (TCP 22) from management network only
- Drop everything else inbound
- Provide the exact `nft` commands for Ubuntu/Debian (the most common RS OS in Pacific environments)
- Reference the security hardening doc's statement that the RS "should be locked down to BGP and SSH"

**Effort:** M  
**Review ref:** §4.2

#### 2.2b Zero-Downtime RS Upgrade Runbook

**File(s):** `runbooks/rs-upgrade.md` (new)  
**Change:** Document the rolling BIRD upgrade procedure:
1. Set RS1 to maintenance mode in IXP Manager (stops new session acceptance)
2. Wait for member sessions to migrate to RS2 (monitor `birdc show protocols`)
3. Upgrade BIRD on RS1 (`apt upgrade bird2`)
4. Verify filter compilation (`birdc configure check`)
5. Restore RS1 from maintenance, repeat for RS2
Include the exact IXP Manager API call or UI steps for maintenance mode toggle.

**Effort:** M  
**Review ref:** §6.1

#### 2.2c IXP Manager Upgrade + Backup Runbook

**File(s):** `runbooks/ixp-manager-upgrade.md` (new)  
**Change:** Document:
1. Pre-upgrade backup procedure (DB dump + `.env` + `ixp-storage` volume snapshot)
2. Image tag update in `docker-compose.yml` with version pinning rationale
3. `docker compose pull && docker compose up -d` sequence
4. Laravel migration run: `docker compose exec app php artisan migrate`
5. Rollback path: restore from pre-upgrade DB dump if migrations fail
6. Note on cache clearing after upgrade (`php artisan cache:clear`, `php artisan config:clear`)

**Effort:** M  
**Review ref:** §6.1

#### 2.2d `ixp-manager-bird-api` — Replace Placeholder with Real Command

**File(s):** `strategy/automation.md`  
**Change:** Replace the reference to `ixp-manager-bird-api` as an external script with the correct IXP Manager CLI integration:
```bash
# Generate and write BIRD config, then reload
docker compose exec app php artisan router:gen-and-write --router rs1
birdc configure
```
Explain that `router:gen-and-write` is IXP Manager's built-in router config generation command and is the correct integration point. Document the 15-minute cron entry that calls this.

**Effort:** M  
**Review ref:** §6.1

#### 2.2e MikroTik Member Config — Complete the Template

**File(s):** `strategy/onboarding.md`  
**Change:** The existing MikroTik RouterOS v7 example references a `PACIXP-RS` BGP template but is missing the output-filter, input-filter, and session options. Complete the template to include:
- Input filter (accept only announced prefixes, reject bogons)
- Output filter (send only own prefixes)
- `add-path-id=yes` if the RS uses ADD-PATH
- A note that MikroTik is common among Pacific Island ISPs and telcos, so this template has higher practical importance than the Cisco/Juniper examples

**Effort:** M  
**Review ref:** §7 item 7

---

## Phase 3 — Medium Priority (completeness & accuracy)

### 3.1 Quick Wins (effort S each)

#### 3.1a IPv6 ND Multicast Exception Documentation

**File(s):** `docs/03-security-hardening.md`, switch template comments  
**Change:** Add a note to the Action 3 (ethertype/multicast filtering) section clarifying that IPv6 ND (ICMPv6 types 135/136, multicast groups ff02::1/ff02::2) is intentionally permitted. The no-multicast rule applies to IP multicast, not to ICMPv6 link-local multicast which is required for IPv6 to function.  
**Effort:** S  
**Review ref:** `TODO.md` (Low, "Document IPv6 ND Multicast Exception")

#### 3.1b HLD Mermaid Label Fix — `docs/01-high-level-design.md`

**File(s):** `docs/01-high-level-design.md` lines 63–77  
**Change:** Update the ISL link label from `"iBGP EVPN (Sub-AS 64501)"` to `"iBGP EVPN (Intra-Sub-AS 64501)"` to avoid the ambiguity between the confederation sub-AS and a standard iBGP session label.  
**Effort:** S  
**Review ref:** §7 item 4

#### 3.1c Routinator Cache Expiry — `strategy/virtualization.md`

**File(s):** `strategy/virtualization.md`  
**Change:** Add a section clarifying: (a) BIRD's RPKI cache expires after 48 hours (`expire keep 172800`), (b) if the MGMT VM fails, operators have a 48-hour window to restore Routinator before BIRD starts rejecting routes, (c) the monitoring system must alert on Routinator RTR session loss. Cross-reference the RPKI fail-closed policy.  
**Effort:** S  
**Review ref:** §9.2

#### 3.1d `send-community` Cleanup — `strategy/onboarding.md`

**File(s):** `strategy/onboarding.md` (all vendor member templates)  
**Change:** Remove `send-community` from all member BGP session templates. Route servers set communities internally; members sending communities to the RS is unnecessary and potentially confusing. If the BGP community policy (item 3.2a) is implemented, add the correct send-community configuration at that point.  
**Effort:** S  
**Review ref:** §9.3  
**Status:** ✓ Completed 2026-06-01 — resolved as side-effect of RTBH implementation (§3.2a). `send-community` retained with RTBH annotation; unnecessary occurrences removed.

#### 3.1e BUM Replication O(N) Documentation

**File(s):** `docs/01-high-level-design.md` or `docs/00-design-principles.md` (EVPN section)  
**Change:** Add a note that BUM (Broadcast, Unknown unicast, Multicast) replication with EVPN Type 3 scales O(N) per packet per VTEP. For the expected IXP traffic profile (minimal BUM: IPv6 ND, rare ARP, rare unknown unicast), this is acceptable at 8 VTEPs with 10G links. Operators should revisit if the VTEP count exceeds ~20.  
**Effort:** S  
**Review ref:** §8.3

#### 3.1f RD/RT Template Variable Note

**File(s):** `configs/switches/arista_sw1.md`, `configs/switches/juniper_sw1.md`  
**Change:** Add a comment to the RD definition (`198.51.100.11:10010`) noting that `10010` is a template variable derived from `VLAN × 1000 + VLAN` and must be updated when new VLANs/VNIs are added. This prevents hardcoded values from propagating incorrectly when the design is extended.  
**Effort:** S  
**Review ref:** §8.1

#### 3.1g MAC Violation Response Procedure — `strategy/onboarding.md`

**File(s):** `strategy/onboarding.md`  
**Change:** Expand the troubleshooting matrix "Admin: Clear port-security on switch" entry with the exact CLI commands and a specific sequence: (1) verify the updated MAC in IXP Manager first, (2) then clear port-security on the switch. Add the Arista command: `clear port-security dynamic interface Ethernet1`. This prevents the common mistake of clearing first and verifying second.  
**Effort:** S  
**Review ref:** §6.2

---

### 3.2 Medium Effort

#### 3.2a BGP Community / RTBH Policy (requires design decision)

**File(s):** `strategy/onboarding.md`, `labs/configs/rs1.cfg`, `docs/03-security-hardening.md` (new section)

**Decision (made 2026-06-01):** RFC 7999 RTBH (`65535:666`) only. No informational tagging or selective no-export communities at this time.

**Completed:**
1. `docs/03-security-hardening.md` — new §3.3 documents RTBH policy, discard addresses, NO_EXPORT tagging, and Pacific DDoS context. MD5 guidance updated (§3.2).
2. `labs/configs/rs1.cfg` — `rtbh_import_v4()` / `rtbh_import_v6()` filter functions added; member template import changed from `import all` to filter; kernel protocol fixed to `import none; export none`.
3. `strategy/onboarding.md` — `next-hop-self` removed from Cisco templates; `send-community` annotated for RTBH; RTBH usage section added with per-vendor examples (Cisco, MikroTik, Juniper).

The RTBH community is specifically called out in the Pacific-IXP Operating Guideline as important for Pacific Island IXPs, which are targets for DDoS traffic from outside the region.

**Effort:** L  
**Review ref:** §10.2, `TODO.md` (Medium, "BGP Community Policy Undefined")

#### 3.2b MLPA Template

**File(s):** `documents/mlpa-template.md` (new), `strategy/onboarding.md`

**Change:**
1. Create a minimal MLPA template in `documents/` — reference the Euro-IX/LINX/AMS-IX standard templates and note that Pacific PACNOG-affiliated IXPs use the MLPA model.
2. Add an MLPA signature step to the beginning of the onboarding checklist in `strategy/onboarding.md`: "Step 0: Member executes MLPA before any technical onboarding begins."

**Effort:** M  
**Review ref:** §10.1, `TODO.md` (Medium, "MLPA Template Missing")

#### 3.2c Member De-Provisioning Workflow

**File(s):** `strategy/onboarding.md`

**Change:** Add a new section "Member De-Provisioning" covering the full de-provisioning sequence:
1. BGP session teardown (IXP Manager: remove router/BGP session)
2. BIRD config regeneration and reload
3. MAC lock removal and port shutdown on switch
4. VLAN removal from port
5. IP address return to IXP prefix pool
6. IXP Manager record archival (not deletion — audit trail)
7. PeeringDB entry update
8. MLPA termination notice

Pacific-specific note: members may go offline for months due to connectivity issues; document the "suspended" state (port shut but not fully deprovisioned) vs. full removal.

**Effort:** M  
**Review ref:** §9.4

#### 3.2d LibreNMS SNMPv3 Guidance

**File(s):** `strategy/automation.md`, `configs/switches/arista_sw1.md`, `configs/switches/juniper_sw1.md`

**Change:**
1. Add an SNMPv3 `authPriv` (SHA + AES) configuration example alongside the existing SNMPv2c config in the switch templates.
2. Add a note at the `PACIXP-public` community string definition: "SNMPv2c community strings are cleartext. For production, use SNMPv3 authPriv. SNMPv2c may be kept only for legacy LibreNMS polling compatibility."
3. Update `strategy/automation.md` to document LibreNMS SNMPv3 device profile setup.

**Effort:** M  
**Review ref:** §6.2

#### 3.2e Alerting Thresholds Documentation

**File(s):** `strategy/automation.md`

**Change:** Add an "Alert Thresholds" section documenting the minimum LibreNMS alert rules:
- BGP session down → alert within 5 minutes
- RPKI validator (Routinator) RTR session unreachable → alert within 1 polling interval
- Port error rate > N errors/5 min → alert (define N per port speed)
- RS VM disk > 80% → alert
- RS VM memory > 90% → alert

Include the LibreNMS alert rule query format for BGP and RPKI checks.

**Effort:** M  
**Review ref:** §6.2, `TODO.md` (High, "No Monitoring & Alerting Setup")

#### 3.2f IPv6 RS Sessions in Lab — `labs/configs/rs1.cfg`, `labs/configs/peers/member1.cfg`

**File(s):** `labs/configs/rs1.cfg`, `labs/configs/peers/member1.cfg`

**Change:** Add IPv6 `protocol bgp` session blocks to `rs1.cfg` for each lab member. The member1.cfg already has an IPv6 neighbor (`3fff:0:1::fe`) that will never establish without a corresponding RS-side session. This creates a misleading lab where IPv6 peering appears configured but never functions.

**Effort:** M  
**Review ref:** §2.2, `TODO.md` (Medium, "No IPv6 Route Server Sessions")

---

## Phase 4 — Low Priority (polish & operational readiness)

### 4.1 New Documents (effort M each — do in one batch)

#### 4.1a Post-Build VXLAN MTU Verification Runbook

**File(s):** `runbooks/post-build-verification.md` (new)

**Change:** Document the DP-11 MTU verification procedure:
- `ping <vtep-ip> size 8972 repeat 5 df-bit` (Arista syntax)
- `ping <vtep-ip> count 5 size 8972 do-not-fragment` (Juniper syntax)
- Expected result: 5/5 success
- Failure response: contact WAN provider, check ISL MTU, verify `ip mtu 9194` on ISL interfaces

**Effort:** S  
**Review ref:** §9.1

#### 4.1b WAN Provider Requirements Document

**File(s):** `documents/wan-provider-requirements.md` (new)

**Change:** Create a one-page document specifying what the IXP must contractually require from WAN providers:
- Minimum MTU: 1600 bytes (to support VXLAN overhead of 50 bytes + standard 1500 MTU payload); recommended: 9216 for jumbo frame support
- No multicast filtering (or explicit exception for EVPN ingress replication traffic)
- BGP AS-path transparency (no prepending by provider)
- Latency SLA between IXP sites (relevant for OSPF convergence timing)

**Effort:** S  
**Review ref:** §9.5

#### 4.1c Addressing Plan Worksheet

**File(s):** `docs/02-addressing-plan.md` (new)

**Change:** Create an IP allocation worksheet with sections for:
- Loopback /32 allocations (from 198.51.100.0/24)
- Point-to-point ISL /30 or /31 allocations
- Peering LAN /26 (IPv4 and IPv6)
- Management network /24

**Effort:** S  
**Review ref:** `TODO.md` (Low, "Create `docs/02-addressing-plan.md`")

### 4.2 Additional Lab Improvements

#### 4.2a Failure Scenario Test Cases

**File(s):** `labs/README.md`

**Change:** Add a "Failure Scenarios" section describing:
- Switch failover: `docker stop sw1` → verify EVPN reconvergence via `birdc show route`
- RS failover: `docker stop rs1` → verify member sessions move to rs2
- RPKI cache loss: `docker stop routinator` → verify RS filter behavior

**Effort:** S  
**Review ref:** `TODO.md` (Low, "Expand Lab to Test Failure Scenarios")

#### 4.2b Lab README Cleanup

**File(s):** `labs/README.md`

**Change:** Add `containerlab destroy -t pacixp.clabs.yml` as the cleanup command. Add a note about the cEOS image import requirement (`docker import cEOS-lab-<version>.tar.xz ceos:latest`).

**Effort:** S  
**Review ref:** `TODO.md` (Low, "Add `containerlab destroy` to Lab README")

### 4.3 Member Operations Additions

#### 4.3a Traffic Engineering Guidance for Dual-Connected Members

**File(s):** `strategy/onboarding.md`

**Change:** Add a section for members connected to both PACIXP and a domestic IXP. Pacific-IXP Operating Guideline notes these members should use local-preference or MED to prefer the domestic IXP path for local traffic. Provide a brief BGP policy example (Cisco/MikroTik/Juniper) setting local-preference 200 for domestic IXP routes.

**Effort:** S  
**Review ref:** `TODO.md` (Low)

#### 4.3b Member SLA Document

**File(s):** `documents/member-sla.md` (new)

**Change:** Create a basic SLA document:
- Port provisioning: within 5 business days of MLPA execution and payment
- BGP session recovery: within 30 minutes of fault detection
- Monthly uptime commitment: 99.9% (excluding scheduled maintenance)
- Scheduled maintenance window: [define]

**Effort:** S  
**Review ref:** §10.3, `TODO.md` (Low, "Define Member SLAs")

---

## Summary Table

| # | Phase | Item | Effort | Files |
|---|-------|------|--------|-------|
| 1 | P1 | RPKI fail-closed filter | M | `strategy/virtualization.md`, `labs/configs/rs1.cfg` |
| 2 | P1 | ✓ Lab RS bogon filter skeleton | M | `labs/configs/rs1.cfg` |
| 3 | P1 | IXP Manager TLS | M | `templates/ixp-manager-docker-compose.yml`, `docs/05-ixp-manager.md` |
| 4 | P2 | Lab BGP timers | S | `labs/configs/sw1.cfg`, `labs/configs/sw2.cfg` |
| 5 | P2 | ✓ Cisco next-hop-self removal | S | `strategy/onboarding.md` |
| 6 | P2 | eAPI HTTP → HTTPS | S | `runbooks/ixp-manager-arista-switch.md` |
| 7 | P2 | ✓ MD5 BGP framing | S | `docs/03-security-hardening.md` |
| 8 | P2 | virtualization.md MariaDB version | S | `strategy/virtualization.md` |
| 9 | P2 | DP-7 OOB address fix | S | `docs/00-design-principles.md` |
| 10 | P2 | HLD remove "or eBGP" | S | `docs/01-high-level-design.md` |
| 11 | P2 | HLD MAC violation → restrict | S | `docs/01-high-level-design.md` |
| 12 | P2 | HLD uRPF clarification | S | `docs/01-high-level-design.md` |
| 13 | P2 | DB backup password | S | `strategy/automation.md` |
| 14 | P2 | Oxidized credentials | S | `strategy/automation.md` |
| 15 | P2 | ICMPv6 Redirect blocking | S | `configs/switches/arista_sw1.md`, `configs/switches/juniper_sw1.md` |
| 16 | P2 | SNMP community warning | S | `configs/switches/arista_sw1.md` |
| 17 | P2 | RS VM firewall runbook | M | `runbooks/rs-vm-hardening.md` (new) |
| 18 | P2 | RS upgrade runbook | M | `runbooks/rs-upgrade.md` (new) |
| 19 | P2 | IXP Manager upgrade runbook | M | `runbooks/ixp-manager-upgrade.md` (new) |
| 20 | P2 | ixp-manager-bird-api replacement | M | `strategy/automation.md` |
| 21 | P2 | MikroTik template completion | M | `strategy/onboarding.md` |
| 22 | P3 | IPv6 ND multicast exception note | S | `docs/03-security-hardening.md` |
| 23 | P3 | HLD Mermaid label fix | S | `docs/01-high-level-design.md` |
| 24 | P3 | Routinator cache expiry docs | S | `strategy/virtualization.md` |
| 25 | P3 | ✓ send-community cleanup | S | `strategy/onboarding.md` |
| 26 | P3 | BUM replication O(N) note | S | `docs/01-high-level-design.md` |
| 27 | P3 | RD/RT template variable note | S | switch templates |
| 28 | P3 | MAC violation response procedure | S | `strategy/onboarding.md` |
| 29 | P3 | ✓ BGP community / RTBH policy | L | `labs/configs/rs1.cfg`, `strategy/onboarding.md`, new doc |
| 30 | P3 | MLPA template | M | `documents/mlpa-template.md` (new), `strategy/onboarding.md` |
| 31 | P3 | Member de-provisioning workflow | M | `strategy/onboarding.md` |
| 32 | P3 | LibreNMS SNMPv3 guidance | M | `strategy/automation.md`, switch templates |
| 33 | P3 | Alerting thresholds | M | `strategy/automation.md` |
| 34 | P3 | IPv6 RS sessions in lab | M | `labs/configs/rs1.cfg`, `labs/configs/peers/member1.cfg` |
| 35 | P4 | MTU verification runbook | S | `runbooks/post-build-verification.md` (new) |
| 36 | P4 | WAN provider requirements | S | `documents/wan-provider-requirements.md` (new) |
| 37 | P4 | Addressing plan worksheet | S | `docs/02-addressing-plan.md` (new) |
| 38 | P4 | Failure scenario test cases | S | `labs/README.md` |
| 39 | P4 | Lab README cleanup | S | `labs/README.md` |
| 40 | P4 | Traffic engineering guidance | S | `strategy/onboarding.md` |
| 41 | P4 | Member SLA document | S | `documents/member-sla.md` (new) |

---

## Effort Summary

| Phase | S items | M items | L items | Notes |
|-------|---------|---------|---------|-------|
| P1 Critical | 0 | 3 | 0 | All three must complete before "production-ready" claim |
| P2 High | 13 | 5 | 0 | S items can be batched in a single session |
| P3 Medium | 7 | 6 | 1 | BGP community (L) requires design decision first |
| P4 Low | 7 | 0 | 0 | Polish; can be deferred without blocking operations |

**Total new files:** 8  
**Total modified files:** ~20
