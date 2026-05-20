# PACIXP TODO

Work identified during code review. Grouped by priority.

---

## Critical (Blocking Production Deployment)

### HTTPS/TLS Not Configured for IXP Manager
- `templates/ixp-manager-docker-compose.yml` exposes port 443 but has no SSL volume or config.
- `docs/05-ixp-manager.md` has no SSL/TLS setup instructions and uses `http://` in examples.
- **Need:** Add Nginx SSL config template, Let's Encrypt / Certbot instructions, and force HTTP→HTTPS redirect.

### RPKI Cache Expiry Policy is "Fail Open"
- `strategy/virtualization.md` documents RPKI behavior as "Fail Open (Warn)".
- **Need:** Change to "Fail Closed" in `strategy/virtualization.md` and ensure `rs1.cfg` reflects this (currently uses `import all`).

### ~~Incomplete Lab Topology~~ ✓ Done
- [x] `.conf`/`.cfg` extension mismatch fixed in `labs/pacixp.clabs.yml`; container-side paths restored to `.conf` (BIRD/FRR standard locations).
- [x] `member2.cfg`–`member5.cfg` created in `labs/configs/peers/`.
- [x] `rs1` exec now assigns both `192.0.2.254/24` and `3fff:0:1::fe/64` on `eth1`.

### ~~labs/README.md Deploy Command Broken~~ ✓ Done
- Deploy command corrected to `pacixp.clabs.yml`.

### ~~RPKI Block Commented Out in rs1.cfg~~ ✓ Done
- `protocol rpki routinator {}` uncommented; points to `172.17.0.1:3323` (Docker bridge gateway) for lab use.

### ~~Routinator Container Missing from Compose~~ ✓ Done
- `nlnetlabs/routinator` is present in `templates/ixp-manager-docker-compose.yml` with RPKI cache volume and RTR port 3323.
- Remaining: pin to a specific image tag (tracked under "No Cron Image Version Pinning").

---

## High Priority (Operational Gaps)

### No Backup/Restore Procedures for IXP Manager
- `strategy/automation.md` mentions "hourly DB dumps" but no script or procedure exists.
- **Need:** Create a backup script (DB + `.env` + storage volume), offsite storage guidance (e.g., S3/RSYNC), and a restore runbook.

### No Monitoring & Alerting Setup
- [x] Add LibreNMS service to `templates/ixp-manager-docker-compose.yml`.
- [x] Documented LibreNMS + Oxidized integration in `strategy/automation.md`.
- **Need:** Add alert thresholds for BGP drops/high error rates to documentation.

### No Zero-Downtime Upgrade Procedures
- No runbook for upgrading BIRD, IXP Manager, or switches without member impact.
- **Need:** Document rolling upgrade approach (maintenance of one RS while other stays active).

### Missing Core Automation Script
- `strategy/automation.md` references `ixp-manager-bird-api`.
- **Need:** Add the script to the repo or provide a link/instructions on how to generate it.

### ~~Ethertype Filtering Missing from Switch Configs~~ ✓ Done
- `IXP-ETHERTYPE-FILTER` MAC ACL added to Arista; `IXP-ETHERTYPE-FILTER` firewall filter added to Juniper. Applied first on all member ports; drops IS-IS, CDP, LACP, and all other non-IP/ARP/IPv6 frames at L2.

### ~~Port-Security Violation Action~~ ✓ Done — `restrict` chosen
- Arista: `violation restrict`; Juniper: `packet-action drop-and-log`. Port stays up; syslog/SNMP trap fires on unknown MAC. Rationale documented in DP-6.

### ~~Juniper Storm-Control Functionally Disabled~~ ✓ Done
- Three `no-*-suppression` flags removed from `IXP-STORM-PROFILE`; `bandwidth-level 10000` now applies to broadcast and multicast per DP-6.

### ~~ACL-IXP-PEERING-V4 Missing IGP Drop Rules~~ ✓ Done
- Arista: `deny ospf any any` and `deny eigrp any any` added before final permit. IS-IS covered by ethertype filter. Juniper: `BLOCK-IGP` term added to `ACL-IXP-PEERING-V4` matching `protocol [ ospf 88 ]`.

### ~~README Badge Overstates Deployment Readiness~~ ✓ Done
- Badge changed to `Engineering Review`. Update to `Production Ready` when all remaining High items are resolved.

---

## Medium Priority (Completeness & Accuracy)

### No IPv6 Route Server Sessions
- `labs/configs/rs1.cfg` has IPv6 templates but the individual `protocol bgp` blocks are IPv4 only.
- `labs/configs/peers/member1.cfg` has an IPv6 neighbor but it will never come up.
- **Need:** Add dual-stack sessions to `rs1.cfg`.

### ~~No Cron Image Version Pinning~~ ✓ Done
- All compose images pinned: `inex/ixp-manager:v6.3.0`, `nlnetlabs/routinator:0.14.1`, `oxidized/oxidized:0.29.1`, `librenms/librenms:24.10.0`.
- Verify pinned tags are still current before production deployment.

### SNMP Community Security
- `configs/switches/arista_sw1.md` uses `PACIXP-public`.
- **Need:** Add a prominent warning comment *at the line* where the community string is defined.

### Lab Route Server Security Filtering
- `labs/configs/rs1.cfg` uses `import all` / `export all`.
- **Need:** Add basic bogon and RPKI/IRR filter examples so the lab reflects production security.

### MLPA Template Missing
- The Pacific-IXP Operating Guideline requires members to execute a Multilateral Peering Agreement (MLPA) with the IXP Association before they can connect to the Route Servers.
- No MLPA template exists in the repo. `strategy/onboarding.md` describes the technical onboarding process but has no reference to a legal agreement.
- **Need:** Create an MLPA template (or reference a standard template from Euro-IX/LINX/AMS-IX) and add a signature requirement to the member onboarding checklist.

### BGP Community Policy Undefined ⚠️ *requires design decision*
- `strategy/onboarding.md` configures `send-community` on member BGP sessions, but PACIXP defines no communities of its own. The Pacific-IXP Operating Guideline explicitly documents BGP communities as a member-facing feature for route control.
- Standard IXP community sets include: no-export to specific peers, prepend on export, blackhole (65535:666 for RTBH), informational tagging by origin.
- **Need:** Decide which BGP communities PACIXP Route Servers will accept, process, and advertise; document the community policy; implement in BIRD RS templates. At minimum, the RTBH blackhole community (65535:666) should be considered — it is explicitly called out in the Pacific-IXP guidelines and the MANRS IXP Implementation Guide.

### Investigate RA Guard and IPv6 First Hop Security for Member Ports
- Member ports currently block Router Advertisements and DHCPv6 servers via `ACL-IXP-PEERING-V6` (L3). This works but has a gap: ICMPv6 Redirect (type 137) is not blocked, and ACL-based RA blocking can be bypassed by fragmented or encapsulated RAs.
- RA Guard (RFC 6105) is the L2-level mechanism for this — it is structure-aware and handles edge cases ACLs miss. On EOS it is part of the IPv6 First Hop Security (FHS) suite alongside DHCPv6 Guard and ND Inspection. Juniper's implementation differs (under `forwarding-options`).
- **Need:** Investigate whether RA Guard should replace or supplement the current ACL entries on Arista and Juniper member ports. Determine whether full FHS (RA Guard + DHCPv6 Guard + ICMPv6 Redirect blocking) is appropriate, and test for interactions with BIRD's own NDP behaviour on the route server. Update both switch templates based on findings.

### DP-7 vs DP-12 OOB Addressing Contradiction
- `docs/00-design-principles.md:111` (DP-7) specifies `192.168.100.0/24` for the OOB management VLAN — an RFC1918 range.
- DP-12 in the same document prohibits RFC1918 and maps OOB management to `203.0.113.0/24`. The HLD uses `203.0.113.0/24`.
- **Need:** Update DP-7 to read `203.0.113.0/24` to match DP-12 and the HLD.

### HLD Allows "OSPF or eBGP" for Underlay
- `docs/01-high-level-design.md:87` says the underlay protocol is "OSPFv2 / OSPFv3 or eBGP".
- DP-8 explicitly decided OSPF-only; an engineer reading the HLD could choose eBGP, creating a deployment inconsistent with all runbooks.
- **Need:** Remove "or eBGP" from `docs/01-high-level-design.md:87` and add a reference to the DP-8 decision.

### BGP Timers Missing from Lab Switch Configs
- `labs/configs/sw1.cfg` and `sw2.cfg` have no `timers` statement on any BGP neighbor.
- DP-13 says "Never leave timers unset"; `rs1.cfg` sets them explicitly (keepalive 10 / hold 30); the switches default to 30/90.
- **Need:** Add `neighbor <ip> timers 10 30` to every BGP neighbor in `sw1.cfg` and `sw2.cfg`.

### Backup Cron Exposes DB Password in Process Table
- `strategy/automation.md:166` uses `mysqldump -u ixp -pPASSWORD`, which exposes the password in `ps` output, shell history, and cron logs.
- **Need:** Replace with `--defaults-extra-file=/run/secrets/db.cnf` reading credentials from a Docker secret or root-owned `.my.cnf`.

### ~~Runbook Uses RFC1918 Addresses (Violates DP-12)~~ ✓ Done
- All RFC1918 addresses in `runbooks/ixp-manager-arista-switch.md` replaced with RFC5737 ranges consistent with `arista_sw1.md`.

---

## Low Priority (Polish & Nice-to-Have)

### Create `docs/02-addressing-plan.md`
- Provide an IP allocation worksheet (Loopbacks, P-P, Peering LAN, MGMT).

### Create `BOM.csv` (Bill of Materials)
- Hardware recommendations and power/rack requirements.

### Missing Member Config Snippets
- [x] Add basic BGP peering templates for Cisco, MikroTik, and Juniper in `strategy/onboarding.md`.

### Document Oxidized Configuration
- [x] Added setup instructions and configuration examples to `strategy/automation.md`.
- [x] Add Oxidized service (and its git volume) to `templates/ixp-manager-docker-compose.yml`.

### Document IPv6 ND Multicast Exception to No-Multicast Rule
- The Pacific-IXP Operating Guideline states the no-multicast rule as: "no multicast frames *except* IPv6 Neighbour Discovery." This exception is not documented anywhere in PACIXP.
- IPv6 ND (NS/NA, ICMPv6 types 135/136) uses link-local multicast (ff02::1, ff02::2) and must be permitted for IPv6 to function on the peering LAN. The current storm-control at 1% does not block ND in practice, but the exception should be explicit.
- **Need:** Add a note to `docs/03-security-hardening.md` Action 3 and the switch template comments clarifying that IPv6 ND multicast is intentionally permitted.

### Document Member Traffic Engineering Guidance (Domestic IXP Preference)
- The Pacific-IXP Operating Guideline notes that members in node-hosting countries with a domestic IXP will have peering sessions across both fabrics for the same local peers, and should use route preferences to direct that traffic through the domestic IXP.
- This guidance is absent from `strategy/onboarding.md`.
- **Need:** Add a section to `strategy/onboarding.md` advising dual-connected members to prefer the domestic IXP path using local-preference or MED.

### Expand Lab to Test Failure Scenarios
- Add scenarios for switch failure (VXLAN failover) and RS failure.

### Define Member SLAs
- Define commitments for port provisioning and BGP recovery.

### Add `containerlab destroy` to Lab README
- Add cleanup instructions and notes about cEOS image imports.

### ~~Juniper Member Port Sets Jumbo MTU~~ ✓ Done
- `mtu 9216` removed from member port `xe-0/0/0` in `configs/switches/juniper_sw1.md`; infrastructure interfaces retain jumbo MTU.

### Arista Member Port Missing `no ip proxy-arp`
- EOS enables Proxy-ARP by default; `configs/switches/arista_sw1.md:101` (interface Ethernet3) does not disable it.
- A member port with Proxy-ARP active may respond to ARP requests for other peers' IPs on the peering LAN.
- **Need:** Add `no ip proxy-arp` to the Ethernet3 member port template.
