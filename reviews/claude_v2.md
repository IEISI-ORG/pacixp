`★ Insight ─────────────────────────────────────`
This project uses a layered documentation pattern where `docs/00-design-principles.md` is intentionally normative (all changes must be evaluated against it), making cross-document consistency errors here especially high-impact — a violation in the principles doc propagates to every downstream decision that cites it.
`─────────────────────────────────────────────────`

Now running the full cross-file verification audit.

---

```
[SEVERITY: Critical]
[TYPE: Contradiction]
File: strategy/virtualization.md:71
Finding: RPKI cache-expiry behavior is documented as "Fail Open (Warn)" — the exact anti-pattern explicitly prohibited by DP-5 and the security hardening guide.
Evidence: "PACIXP Default: Fail Open (Warn)." (strategy/virtualization.md:71) vs. "route servers must reject or hold routes" (docs/00-design-principles.md:76) and "route servers must fail closed" (docs/03-security-hardening.md:77); "RPKI fail-open on cache expiry" is listed as a rejected anti-pattern (docs/00-design-principles.md:323).
Impact: A Routinator outage silently disables RPKI enforcement; hijacked prefixes within any member's AS-SET propagate to all members for the cache TTL (~1 hour).
Fix: Change strategy/virtualization.md line 71 to state "Fail Closed" and implement `rpki_max_roas` or equivalent BIRD hold behavior; update rs1.cfg to enforce this.

[SEVERITY: Critical]
[TYPE: Contradiction]
File: labs/configs/rs1.cfg:11-13
Finding: The entire RPKI protocol block is commented out, disabling RPKI enforcement in the only route-server config file in the repo.
Evidence: `# protocol rpki routinator { # remote 203.0.113.50 port 3323; # }` (labs/configs/rs1.cfg:11-13) — the only RS config in the repository.
Impact: The lab cannot validate any RPKI behavior described in DP-5 or docs/03-security-hardening.md; engineers testing against this config will assume RPKI is active when it is not.
Fix: Uncomment the RPKI block and add a Routinator container to labs/pacixp.clabs.yml, or add an explicit comment marking this as a known lab-only gap.

[SEVERITY: Critical]
[TYPE: Contradiction]
File: labs/configs/rs1.cfg:24-29
Finding: All five member sessions use `import all` / `export all` with zero filtering, contradicting DP-5 which requires active IRR and RPKI enforcement on every session.
Evidence: `import all; # In production: apply RPKI, IRR, bogon, and max-prefix filters` and `export all;` for both ipv4 and ipv6 address families (labs/configs/rs1.cfg:24-29).
Impact: The lab route server forwards all prefixes without validation; any lab test proves connectivity only, not the security posture claimed in the docs.
Fix: Replace `import all`/`export all` with bogon-filter and max-prefix stub implementations; add an RPKI filter block so the lab mirrors the production security posture.

[SEVERITY: Critical]
[TYPE: Broken Reference]
File: labs/pacixp.clabs.yml:28,42,50,58,66,74
Finding: Every `binds:` entry in the topology file references `.conf` extension but every actual config file in `labs/configs/` uses `.cfg`.
Evidence: `- configs/rs1.conf:/etc/bird/bird.conf` (line 28) — actual file: `labs/configs/rs1.cfg`; identical mismatch for member1–5 (`configs/peers/member1.conf` through `member5.conf`, lines 42–74).
Impact: `containerlab deploy` fails immediately with bind-mount errors for all six nodes; the lab cannot be started as written.
Fix: Rename all bind paths in pacixp.clabs.yml from `.conf` to `.cfg` (or rename the actual config files to `.conf`).

[SEVERITY: Critical]
[TYPE: Missing File]
File: labs/pacixp.clabs.yml:50,58,66,74
Finding: pacixp.clabs.yml defines member2 through member5 but only `labs/configs/peers/member1.cfg` exists in the repository.
Evidence: `- configs/peers/member2.conf:/etc/frr/frr.conf` through `member5.conf` (lines 50–74); `ls labs/configs/peers/` returns only `member1.cfg`.
Impact: Containerlab cannot start member2–5; multi-member scenarios and the VXLAN cross-switch test (member4/5 are on sw2) are completely untestable.
Fix: Create `member2.cfg` through `member5.cfg` following the member1 pattern with sequential ASNs (65002–65005) and peering IPs (192.0.2.2–192.0.2.5).

[SEVERITY: Critical]
[TYPE: Incomplete]
File: templates/ixp-manager-docker-compose.yml:79-88; docs/05-ixp-manager.md:17
Finding: Nginx exposes port 443 but no SSL certificate volume, TLS config file, or HTTPS redirect is present; the example APP_URL uses `http://`.
Evidence: `ports: ["443:443"]` with no certificate volume mount and no Nginx SSL config (templates/ixp-manager-docker-compose.yml:79-88); `APP_URL=http://ixp.pacixp.net` (docs/05-ixp-manager.md:17).
Impact: Admin credentials, API tokens, and member management data transit unencrypted; port 443 is bound but serves nothing or plain HTTP.
Fix: Add an Nginx SSL config template, Let's Encrypt/Certbot volume mount and instructions, and an HTTP→HTTPS redirect; change the APP_URL example to `https://`.

[SEVERITY: High]
[TYPE: Contradiction]
File: TODO.md:33; templates/ixp-manager-docker-compose.yml
Finding: TODO.md marks "[x] Added LibreNMS service to templates/ixp-manager-docker-compose.yml" as completed but no LibreNMS service exists in the compose file.
Evidence: `- [x] Added LibreNMS service to \`templates/ixp-manager-docker-compose.yml\`.` (TODO.md:33); compose services are: db, ixp-manager, nginx, cron, redis — no librenms.
Impact: The Oxidized configuration in strategy/automation.md references `http://librenms:8000/api/v0/oxidized` (line 144), a hostname that does not exist in the compose network; monitoring is absent from the deployed stack.
Fix: Add the LibreNMS service to the compose file, or revert the TODO.md checkbox and mark it as incomplete.

[SEVERITY: High]
[TYPE: Contradiction]
File: TODO.md:80-81; templates/ixp-manager-docker-compose.yml
Finding: TODO.md marks "[x] Added Oxidized service to templates/ixp-manager-docker-compose.yml" as completed but no Oxidized service exists in the compose file.
Evidence: `- [x] Added Oxidized service to \`templates/ixp-manager-docker-compose.yml\`.` (TODO.md:80-81); compose file does not include an oxidized service; strategy/virtualization.md:53 lists it as a required container.
Impact: The Disaster Recovery strategy's "Config Backups (Oxidized)" section (strategy/automation.md section 5.2) has no deployable implementation; switch configs are not backed up.
Fix: Add the Oxidized service (and its git volume) to the compose file, or revert the TODO checkbox.

[SEVERITY: High]
[TYPE: Missing File]
File: templates/ixp-manager-docker-compose.yml; strategy/virtualization.md:53; labs/configs/rs1.cfg:12
Finding: The Routinator RPKI validator container is listed as a required service in strategy/virtualization.md but is absent from the Docker Compose template and has no deployment instructions.
Evidence: `routinator | nlnetlabs/routinator | Downloads global RPKI ROAs.` (strategy/virtualization.md:53); `remote 203.0.113.50 port 3323;` in the commented-out rs1.cfg RPKI block (line 12); no routinator service in templates/ixp-manager-docker-compose.yml.
Impact: RPKI enforcement cannot be enabled even if the rs1.cfg protocol block is uncommented; the documented security architecture is undeployable from the provided templates.
Fix: Add `nlnetlabs/routinator` to the compose file with its RPKI cache volume and RTR port (3323) exposed to the backend network.

[SEVERITY: High]
[TYPE: Broken Reference]
File: labs/README.md:4
Finding: The deploy command uses `pacixp.clab.yml` but the topology file is named `pacixp.clabs.yml`.
Evidence: `sudo containerlab deploy --topo pacixp.clab.yml` (labs/README.md:4); actual filename: `labs/pacixp.clabs.yml`.
Impact: The documented deploy command fails with a file-not-found error for every first-time operator.
Fix: Correct the filename in labs/README.md:4 to `pacixp.clabs.yml`.

[SEVERITY: High]
[TYPE: Contradiction]
File: labs/configs/rs1.cfg:37-41; labs/configs/peers/member1.cfg:15-16
Finding: rs1.cfg defines only IPv4 BGP sessions; member1.cfg configures an IPv6 neighbor (`3fff:0:1::fe`) that can never establish because no matching IPv6 session exists on the RS.
Evidence: All five protocol blocks: `protocol bgp m1 from member { neighbor 192.0.2.1 as 65001; }` (rs1.cfg:37-41, IPv4 only); `neighbor 3fff:0:1::fe remote-as 64500` (member1.cfg:15); DP-10: "Each member session has two address families activated" (docs/00-design-principles.md:154).
Impact: IPv6 route server functionality is silently untested; DP-10 dual-stack requirement is unvalidated in the lab.
Fix: Add IPv6 protocol blocks (`protocol bgp m1_v6 from member { neighbor 3fff:0:1::1 as 65001; }`) for all five members in rs1.cfg.

[SEVERITY: High]
[TYPE: Incomplete]
File: labs/pacixp.clabs.yml:33
Finding: The rs1 exec block assigns only an IPv4 address; no IPv6 address (`3fff:0:1::fe/64`) is assigned to eth1 despite DP-10 requiring dual-stack.
Evidence: `exec: - ip addr add 192.0.2.254/24 dev eth1` (labs/pacixp.clabs.yml:33); no `ip -6 addr add 3fff:0:1::fe/64 dev eth1` line.
Impact: IPv6 BGP sessions from members to RS1 fail at L3; IPv6 peering is untestable in the lab.
Fix: Add `- ip -6 addr add 3fff:0:1::fe/64 dev eth1` to the rs1 exec block in pacixp.clabs.yml.

[SEVERITY: High]
[TYPE: Security]
File: configs/switches/juniper_sw1.md:113-121
Finding: The `IXP-STORM-PROFILE` uses `no-broadcast-suppression`, `no-multicast-suppression`, and `no-unknown-unicast-suppression` inside the `all` stanza, which in Junos disables suppression for those traffic types — making the bandwidth-level apply to nothing.
Evidence: `all { bandwidth-level 10000; no-broadcast-suppression; no-multicast-suppression; no-unknown-unicast-suppression; }` (juniper_sw1.md:113-121); DP-6: "Storm control: Broadcast + multicast ≤ 1% of link" is listed as non-negotiable (docs/00-design-principles.md:97).
Impact: Storm control is configured but functionally disabled on all Juniper member ports; a misbehaving member can flood the fabric without restriction, violating DP-6.
Fix: Remove the three `no-*` suppression flags from the `all` stanza so the 10 Mbps bandwidth-level applies to broadcast and multicast traffic.

[SEVERITY: High]
[TYPE: Contradiction]
File: configs/switches/arista_sw1.md:50-56; docs/03-security-hardening.md:48
Finding: ACL-IXP-PEERING-V4 only blocks DHCP and then permits all IP traffic; it does not drop OSPF (IP 89), EIGRP (IP 88), or IS-IS despite DP-6 requiring IGP filtering and the hardening guide explicitly listing these as DROP.
Evidence: `50 permit ip any any` is the final rule in ACL-IXP-PEERING-V4 (arista_sw1.md:56); hardening guide table: "OSPF/EIGRP/IS-IS | Multicast ranges | DROP" (docs/03-security-hardening.md:48); DP-6: "IGP filtering: Drop OSPF/IS-IS/EIGRP" is a non-negotiable control (docs/00-design-principles.md:100).
Impact: A member with active OSPF can form an adjacency across the peering LAN and inject routes into the PACIXP underlay OSPF domain.
Fix: Add `deny ospf any any`, `deny eigrp any any`, and IS-IS Ethertype drop entries to ACL-IXP-PEERING-V4 before the final permit rule; apply equivalent rules in the Juniper filter.

[SEVERITY: High]
[TYPE: Contradiction]
File: README.md:3; docs/01-high-level-design.md:7; TODO.md:8-22
Finding: The README badge claims `Status: Production Ready` but the HLD header states `Status: Engineering Review` and TODO.md has a "Critical (Blocking Production Deployment)" section with three unresolved items.
Evidence: `![Status](https://img.shields.io/badge/Status-Production%20Ready-green)` (README.md:3); `**Status** | Engineering Review` (docs/01-high-level-design.md:7); TODO.md Critical section (lines 8-22) lists HTTPS/TLS, RPKI fail-open, and incomplete lab topology as blocking.
Impact: Grant funders and deployers (the stated target audience) are misled about deployment readiness.
Fix: Change the README badge to `Engineering Review` to match the HLD; update to `Production Ready` only after all Critical TODO items are resolved.

[SEVERITY: High]
[TYPE: Contradiction]
File: docs/00-design-principles.md:111
Finding: DP-7 states the OOB management VLAN uses `192.168.100.0/24` (RFC1918), directly contradicting DP-12 in the same file which prohibits RFC1918 in examples.
Evidence: "VLAN 99 / `192.168.100.0/24`" (docs/00-design-principles.md:111); DP-12 address replacement map: `203.0.113.0/24` for OOB management (docs/00-design-principles.md:213); RFC1918 ranges listed as "Prohibited" in the same table (line 219); HLD uses `203.0.113.0/24` (docs/01-high-level-design.md:133).
Impact: Two sections of the same normative document give contradictory addressing guidance; an operator applying DP-7 will choose a range that violates DP-12.
Fix: Update docs/00-design-principles.md:111 to read `VLAN 99 / 203.0.113.0/24` consistent with DP-12 and the HLD.

[SEVERITY: High]
[TYPE: Security]
File: runbooks/ixp-manager-arista-switch.md:35-36,80,133,139
Finding: The runbook uses RFC1918 addresses (`10.0.0.11`, `192.168.100.50`, `192.168.100.11`) for sFlow source/destination and switch management examples, violating DP-12.
Evidence: `sflow source 10.0.0.11` (line 35); `sflow destination 192.168.100.50 6343` (line 36); `Hostname/IP: 192.168.100.11` and troubleshooting `ping 192.168.100.11` (lines 80, 133, 139); configs/switches/arista_sw1.md uses `203.0.113.11/24` for the same management interface — different range, same role.
Impact: An operator following this runbook configures RFC1918 management addresses that may conflict with their existing network; arista_sw1.md and the runbook give contradictory management IP examples for the same switch.
Fix: Replace all RFC1918 addresses in the runbook with RFC5737 documentation ranges (`198.51.100.11` for sFlow source, `203.0.113.11` for management IP) to align with arista_sw1.md and DP-12.

[SEVERITY: High]
[TYPE: Missing Implementation]
File: configs/switches/arista_sw1.md; configs/switches/juniper_sw1.md
Finding: DP-9 and docs/03-security-hardening.md:84 require uRPF on member ports but neither switch template configures it.
Evidence: DP-9: "uRPF and ingress ACLs on all member ports" (docs/00-design-principles.md:139); hardening guide: "uRPF: Enabled on switch ports where hardware supports it (loose mode)" (docs/03-security-hardening.md:84); no `ip verify unicast source reachable-via any` in arista_sw1.md; no `rpf-check` in juniper_sw1.md.
Impact: Without uRPF, a member can source traffic from any IP in the peering LAN subnet; anti-spoofing relies solely on the per-member ACL, which the template shows as `permit ip any any`.
Fix: Add `ip verify unicast source reachable-via any` to the Ethernet3 example in arista_sw1.md; add `family inet { rpf-check; }` to the Juniper member port unit.

[SEVERITY: High]
[TYPE: Missing File]
File: configs/switches/arista_sw1.md:13
Finding: The Arista config template's pre-deployment checklist directs engineers to validate IPs against `02-addressing-plan.md`, but this file does not exist.
Evidence: "Validate IP Addressing against the `02-addressing-plan.md`." (configs/switches/arista_sw1.md:13); `docs/02-addressing-plan.md` is absent from the repository.
Impact: Deployers are directed to a non-existent document at a critical pre-deployment verification step, increasing the risk of deploying with documentation addresses unchanged.
Fix: Create `docs/02-addressing-plan.md` (noted in TODO.md as low priority); at minimum update the reference in arista_sw1.md to point to the addressing tables in docs/01-high-level-design.md section 4.

[SEVERITY: Medium]
[TYPE: Contradiction]
File: labs/configs/sw1.cfg:65-71; labs/configs/sw2.cfg:57-63
Finding: Lab switch configs have no BGP timer statements on any neighbor, violating DP-13 which explicitly states "Never leave timers unset."
Evidence: `neighbor 198.51.100.5 remote-as 64502` with no following `timers` line (sw1.cfg:65); DP-13: "Never leave timers unset. Vendor defaults are: Arista keepalive 30 / hold 90" (docs/00-design-principles.md:244); rs1.cfg does set explicit timers (lines 22-23).
Impact: Lab switches default to keepalive 30 / hold 90 instead of the specified 10 / 30; failure detection in the lab will take up to 90 seconds rather than 30, masking the timer tuning documented in DP-13.
Fix: Add `neighbor <ip> timers 10 30` to every BGP neighbor in sw1.cfg and sw2.cfg.

[SEVERITY: Medium]
[TYPE: Security]
File: strategy/automation.md:166
Finding: The database backup cron example embeds the DB password as a CLI argument (`-pPASSWORD`), exposing it in the process table, shell history, and cron logs.
Evidence: `docker exec ixp-manager-db-1 mysqldump -u ixp -pPASSWORD ixp > /backups/ixp_$(date +\%H).sql` (strategy/automation.md:166).
Impact: Any user with `ps` access on the host, or read access to cron logs, can recover the IXP Manager database password.
Fix: Replace with `mysqldump --defaults-extra-file=/run/secrets/db.cnf` reading credentials from a Docker secret or a root-owned `.my.cnf` file not world-readable.

[SEVERITY: Medium]
[TYPE: Contradiction]
File: docs/01-high-level-design.md:87
Finding: The HLD describes the underlay protocol as "OSPFv2 (IPv4) / OSPFv3 (IPv6) or eBGP" but the Architecture Decisions section in docs/00-design-principles.md explicitly decides OSPF (not BGP) for the underlay.
Evidence: "Protocol: OSPFv2 (IPv4) / OSPFv3 (IPv6) or eBGP." (docs/01-high-level-design.md:87); "OSPF (not BGP) for the underlay… every engineer understands it" (docs/00-design-principles.md:124).
Impact: An engineer reading the HLD may choose eBGP for the underlay, creating a non-standard deployment inconsistent with all runbooks, training, and the simplicity rationale of DP-8.
Fix: Remove "or eBGP" from docs/01-high-level-design.md:87 and add a reference to the DP-8 OSPF decision.

[SEVERITY: Medium]
[TYPE: Security]
File: templates/ixp-manager-docker-compose.yml:54,97
Finding: Both the ixp-manager and cron services use the `latest` Docker tag, making deployments non-reproducible.
Evidence: `image: inex/ixp-manager:latest` at lines 54 and 97 (templates/ixp-manager-docker-compose.yml).
Impact: A re-deploy after an upstream version bump can silently break the portal; `latest` prevents tracking what version is running or detecting supply-chain changes.
Fix: Pin both services to a specific version tag (e.g., `inex/ixp-manager:v6.4.0`); noted in TODO.md as medium priority.

---

## Prioritized Action List

Ordered by impact. Each item states: file, change, expected outcome.

1. **`labs/pacixp.clabs.yml` lines 28,42,50,58,66,74** — Change all six bind paths from `.conf` to `.cfg` extension. Lab becomes deployable.
2. **`labs/configs/peers/`** — Create `member2.cfg` through `member5.cfg` following the member1 pattern. Enables multi-member and VXLAN cross-switch lab testing.
3. **`strategy/virtualization.md:71`** — Change "Fail Open (Warn)" to "Fail Closed". Eliminates contradiction with DP-5 and the hardening guide.
4. **`labs/configs/rs1.cfg:11-13`** — Uncomment RPKI protocol block; add Routinator to `labs/pacixp.clabs.yml`. Lab validates RPKI enforcement.
5. **`labs/configs/rs1.cfg:24-29`** — Replace `import all`/`export all` with bogon-filter and max-prefix stub filters. Lab route server reflects production security posture.
6. **`templates/ixp-manager-docker-compose.yml`** — Add Nginx TLS config volume, Certbot service, and HTTP→HTTPS redirect; update `APP_URL` to `https://` in docs/05-ixp-manager.md. Eliminates plaintext IXP Manager admin interface.
7. **`templates/ixp-manager-docker-compose.yml`** — Add LibreNMS and Oxidized services (and revert TODO.md checkboxes if not adding). Resolves two false-completion entries and enables monitoring/backup as documented.
8. **`templates/ixp-manager-docker-compose.yml`** — Add `nlnetlabs/routinator` service with RPKI cache volume and RTR port 3323. RPKI enforcement becomes deployable via the compose template.
9. **`labs/README.md:4`** — Change `pacixp.clab.yml` to `pacixp.clabs.yml`. Deploy command works for first-time operators.
10. **`labs/pacixp.clabs.yml:33`** — Add `- ip -6 addr add 3fff:0:1::fe/64 dev eth1` to rs1 exec block. Enables IPv6 BGP sessions from members to RS1.
11. **`labs/configs/rs1.cfg`** — Add IPv6 member session blocks (`m1_v6` through `m5_v6`) with IPv6 peering addresses. Lab validates dual-stack RS behavior per DP-10.
12. **`configs/switches/juniper_sw1.md:113-121`** — Remove `no-broadcast-suppression`, `no-multicast-suppression`, `no-unknown-unicast-suppression` from storm-control profile. Storm control is functionally restored on Juniper member ports.
13. **`configs/switches/arista_sw1.md:50-56`** — Add `deny ospf any any`, `deny eigrp any any`, IS-IS Ethertype deny before final permit in ACL-IXP-PEERING-V4. Prevents IGP adjacency formation across the peering LAN.
14. **`docs/00-design-principles.md:111`** — Change `192.168.100.0/24` to `203.0.113.0/24` in DP-7. Eliminates internal contradiction between DP-7 and DP-12 in the same normative document.
15. **`runbooks/ixp-manager-arista-switch.md:35-36,43-44,80,133,139`** — Replace RFC1918 addresses with RFC5737 ranges; change `protocol http` to `protocol https`. Runbook complies with DP-12; eAPI secured.
16. **`configs/switches/arista_sw1.md`** — Add `ip verify unicast source reachable-via any` to the Ethernet3 member port example; add equivalent to juniper_sw1.md. Anti-spoofing gap between docs and config templates closed.
17. **`README.md:3`** — Change badge from `Production Ready` to `Engineering Review`. Maturity claim matches HLD and TODO state.
18. **`labs/configs/sw1.cfg`, `labs/configs/sw2.cfg`** — Add `neighbor <ip> timers 10 30` to every BGP neighbor. Lab validates the DP-13 timer specification.
19. **`strategy/automation.md:166`** — Replace `-pPASSWORD` with `--defaults-extra-file=` referencing a Docker secret. DB password no longer exposed in process table.
20. **`docs/02-addressing-plan.md`** — Create file with IP allocation worksheet (or redirect arista_sw1.md:13 to docs/01-high-level-design.md section 4). Pre-deployment checklist no longer sends deployers to a missing document.

`★ Insight ─────────────────────────────────────`
The two most structurally interesting failure modes here: (1) The Juniper storm-control bug is a classic "negation trap" — Junos uses `no-X-suppression` to *exclude* a traffic type from a profile, so listing all three inside `all {}` means the bandwidth-level applies to nothing. It reads as "do X but not broadcast, not multicast, not unicast" — i.e., "do nothing." (2) The TODO.md false-completion entries (LibreNMS, Oxidized checked off but absent from the compose file) suggest the work was planned in the TODO and the checkbox was marked before the code was written — a workflow hazard with markdown-based task tracking.
`─────────────────────────────────────────────────`
