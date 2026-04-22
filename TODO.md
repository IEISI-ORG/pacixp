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

### Incomplete Lab Topology
- `labs/pacixp.clabs.yml` references `.conf` files, but repo uses `.cfg` extension.
- Only `member1.cfg` exists; `member2.cfg` through `member5.cfg` are missing.
- `rs1` node in `labs/pacixp.clabs.yml` is missing `ip addr add` for IPv6 address `3fff:0:1::fe/64`.
- **Need:** Rename files to match `.clabs.yml` (or vice versa), generate missing member configs, and fix IPv6 address assignment.

---

## High Priority (Operational Gaps)

### No Backup/Restore Procedures for IXP Manager
- `strategy/automation.md` mentions "hourly DB dumps" but no script or procedure exists.
- **Need:** Create a backup script (DB + `.env` + storage volume), offsite storage guidance (e.g., S3/RSYNC), and a restore runbook.

### No Monitoring & Alerting Setup
- [x] Added LibreNMS service to `templates/ixp-manager-docker-compose.yml`.
- [x] Documented LibreNMS + Oxidized integration in `strategy/automation.md`.
- **Need:** Add alert thresholds for BGP drops/high error rates to documentation.

### No Zero-Downtime Upgrade Procedures
- No runbook for upgrading BIRD, IXP Manager, or switches without member impact.
- **Need:** Document rolling upgrade approach (maintenance of one RS while other stays active).

### Missing Core Automation Script
- `strategy/automation.md` references `ixp-manager-bird-api`.
- **Need:** Add the script to the repo or provide a link/instructions on how to generate it.

---

## Medium Priority (Completeness & Accuracy)

### No IPv6 Route Server Sessions
- `labs/configs/rs1.cfg` has IPv6 templates but the individual `protocol bgp` blocks are IPv4 only.
- `labs/configs/peers/member1.cfg` has an IPv6 neighbor but it will never come up.
- **Need:** Add dual-stack sessions to `rs1.cfg`.

### No Cron Image Version Pinning
- `templates/ixp-manager-docker-compose.yml` uses `inex/ixp-manager:latest`.
- **Need:** Pin to a specific version (e.g., `v6.3.0`) to ensure reproducible deployments.

### SNMP Community Security
- `configs/switches/arista_sw1.md` uses `PACIXP-public`.
- **Need:** Add a prominent warning comment *at the line* where the community string is defined.

### Lab Route Server Security Filtering
- `labs/configs/rs1.cfg` uses `import all` / `export all`.
- **Need:** Add basic bogon and RPKI/IRR filter examples so the lab reflects production security.

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
- [x] Added Oxidized service to `templates/ixp-manager-docker-compose.yml`.

### Expand Lab to Test Failure Scenarios
- Add scenarios for switch failure (VXLAN failover) and RS failure.

### Define Member SLAs
- Define commitments for port provisioning and BGP recovery.

### Add `containerlab destroy` to Lab README
- Add cleanup instructions and notes about cEOS image imports.
