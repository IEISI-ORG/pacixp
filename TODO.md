# PacIXP TODO

Work identified during code review. Grouped by priority.

---

## Critical (Blocking Production Deployment)

### HTTPS/TLS Not Configured for IXP Manager
- `templates/ixp-manager-docker-compose.yml` only exposes port 80 (HTTP)
- `docs/05-ixp-manager.md` has no SSL/TLS setup instructions
- Add nginx SSL config, Let's Encrypt certificate setup, and HTTP→HTTPS redirect
- Mark plain HTTP deployment as a security risk

### RPKI Cache Expiry Policy is "Fail Open"
- `strategy/virtualization.md` line 71 documents RPKI cache expiry behavior as "Fail Open (Warn)"
- This means routes of unknown validity are accepted — an RPKI-INVALID route could slip through if Routinator is stale
- Change to "Fail Closed" or document the explicit risk acceptance decision

---

## High Priority (Operational Gaps)

### No Backup/Restore Procedures for IXP Manager
- `strategy/automation.md` mentions "hourly DB dumps" but no procedure is documented anywhere
- Need: backup script or cron command, offsite storage guidance, and a tested restore procedure
- Without this, a DB corruption event means permanent data loss

### No Monitoring & Alerting Setup
- No documentation for alert thresholds, on-call escalation, or paging configuration
- Should cover: BGP session down, high error rate on member ports, RPKI validator staleness, disk/memory thresholds
- Prometheus/Grafana or MRTG + Smokeping integration should be documented end-to-end

### No Zero-Downtime Upgrade Procedures
- No runbook for upgrading BIRD, IXP Manager, switches, or Routinator without member impact
- At minimum, document: rolling upgrade approach, pre-upgrade health checks, rollback steps

### Missing Member Lab Configs
- `labs/pacixp.clabs.yml` references `member2.cfg` through `member5.cfg` under `labs/configs/peers/`
- Only `member1.cfg` exists — the lab topology cannot be deployed as documented
- Add the missing configs or provide a generation script

---

## Medium Priority (Completeness & Accuracy)

### Broken README Links
- `README.md` references `BOM.csv` (Bill of Materials) and `docs/02-addressing-plan.md` — neither file exists
- `README.md` references `runbooks/member-onboarding.md` — does not exist (only `strategy/onboarding.md` does)
- Either create these files or remove the references

### Missing Files Referenced in Docs
| File | Referenced In | Status |
|------|--------------|--------|
| `BOM.csv` | `README.md` | Missing |
| `docs/02-addressing-plan.md` | `README.md` | Missing |
| `runbooks/member-onboarding.md` | `README.md` | Missing |
| `ixp-manager-bird-api` script | `strategy/automation.md` | Missing — not in repo |
| Member config snippets (Cisco, MikroTik) | `strategy/onboarding.md` | Missing |

### No IPv6 Route Server Configuration
- Design claims dual-stack (IPv4 + IPv6), but `labs/configs/rs1.cfg` only shows IPv4 BGP
- `labs/configs/peers/member1.cfg` explicitly disables IPv6 (`no ipv6 forwarding`)
- Add IPv6 BIRD protocol blocks to `rs1.cfg` and a dual-stack member peering example

### No Cron Image Version Pinning in Docker Compose
- `templates/ixp-manager-docker-compose.yml` uses `inex/ixp-manager:latest`
- `latest` is not reproducible — a breaking upstream release will silently break deployments
- Pin to a specific version tag (e.g., `v6.3.0`) and document the upgrade process

### SNMP Community String in Switch Configs
- `configs/switches/arista_sw1.md` uses example community string `pacix-public`
- Add a prominent comment that this must be replaced with a site-specific randomized string before deployment

### Lab Route Server Has No Security Filtering
- `labs/configs/rs1.cfg`: `export all` and `import all` are used as placeholders with a comment saying "filter this in production"
- Add at minimum bogon filtering and a basic IRR/RPKI filter demonstration so the lab reflects the production security posture

### Lab Switches Missing OSPF Underlay Config
- `labs/configs/sw1.cfg` and `sw2.cfg` reference BGP neighbors at Layer-3 IPs but don't include the OSPF underlay that makes those IPs reachable
- Either add OSPF config to the lab switches or add static routes — the current configs are incomplete and won't work as-is

### Lab Configs Not Marked as "Lab Only"
- `labs/configs/sw1.cfg` and `sw2.cfg` lack ACLs, storm control, port security, and BPDU guard
- Add a prominent `# LAB ONLY — NOT FOR PRODUCTION` header to prevent accidental use as a production template

---

## Low Priority (Polish & Nice-to-Have)

### Create `docs/02-addressing-plan.md`
- Provide an IP address allocation worksheet covering: loopback ranges, P-P link ranges, peering LAN (IPv4 + IPv6), management VLAN, and ASN allocation guidance for member registration

### Create `BOM.csv` (Bill of Materials)
- Hardware recommendations (Arista, Juniper, EdgeCore options), rough costs, power/rack requirements
- Useful for grant applications and procurement planning

### Add EdgeCore / Cisco / MikroTik Configuration Examples
- `strategy/onboarding.md` promises config snippets for Cisco IOS, Juniper, and MikroTik but none are provided
- At minimum, add a basic MikroTik BGP peering example (most common member device in Pacific Island networks)

### Document Oxidized Configuration
- `strategy/automation.md` mentions Oxidized for switch config backups but provides no setup instructions
- Add Oxidized credentials setup (SSH key), device list format, and Git repo integration

### Document RPKI Validator (Routinator) Setup
- Routinator is listed as a container in `strategy/virtualization.md` but has no setup runbook
- Add: install steps, initial RPKI data sync, integration with BIRD, cache refresh frequency

### Add IRR Fetching Detail to Automation Docs
- `strategy/automation.md` does not mention which tool fetches IRR data (bgpq4? bgpq3?) or how to configure it
- Add tool name, install steps, and the cron schedule used to refresh prefix lists

### Expand Lab to Test Failure Scenarios
- Current lab only validates the happy path (L2 reachability, BGP up, route exchange)
- Add test cases for: switch failure (VXLAN failover), route server failure (members fall back to direct peering or graceful shutdown), member MAC violation (quarantine VLAN activation)

### Define Member SLAs in Onboarding Docs
- `strategy/onboarding.md` uses "Day 0-2" / "Day 3" timelines but no explicit commitments
- Define: maximum time from port request to go-live, BGP session recovery time objective, escalation path if deadline is missed

### Separate Management VLANs for RS and MGMT VMs
- `strategy/virtualization.md` puts RS VMs and MGMT VMs on the same VLAN 99
- Recommend splitting into VLAN 98 (MGMT infrastructure) and VLAN 99 (Route Server management) for blast-radius reduction

### Add Proxmox Cluster/HA Documentation
- `strategy/virtualization.md` describes single-node Proxmox; ZFS replication is mentioned but not detailed
- Document multi-node Proxmox cluster setup (or at least ZFS send/receive replication schedule) for HA

### Add `containerlab destroy` to Lab README
- `labs/README.md` only shows the deploy command; no teardown instruction
- Add cleanup command and note about image disk space

### Add cEOS Image Import Instructions to Lab README
- `labs/README.md` does not mention that `ceos:4.32.0F` must be imported manually before deployment
- Without this, `containerlab deploy` fails with a cryptic error
