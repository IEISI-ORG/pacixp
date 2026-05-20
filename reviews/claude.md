I now have a complete picture of the repository. Let me produce the comprehensive review.

`★ Insight ─────────────────────────────────────`
The review prompt asks for output to console only, meaning this review is the output itself — no file writes. A key analytical technique here is cross-file consistency checking: comparing what one document *claims* against what the configs *actually do*. The most revealing findings often live in these gaps (e.g., `strategy/virtualization.md` documenting "Fail Open" while DP-5 mandates "Fail Closed").
`─────────────────────────────────────────────────`

---

# PACIXP Repository: Comprehensive Engineering & Business Review

**Review Date:** 2026-05-20
**Reviewed By:** Senior Multidisciplinary Review Team (AI-Assisted)
**Scope:** Full repository at `/home/terry/pacixp` — read-only, no modifications made
**Repository:** IEISI-ORG/pacixp (local copy reviewed; GitHub URL referenced in prompt)
**Reviewer Commitment:** All findings are evidence-based; speculation and inference are explicitly labelled.

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Repository Overview](#2-repository-overview)
3. [Engineering Assessment](#3-engineering-assessment)
4. [Security Review](#4-security-review)
5. [Product & Market Review](#5-product--market-review)
6. [Governance & Organizational Review](#6-governance--organizational-review)
7. [Infrastructure & Operational Review](#7-infrastructure--operational-review)
8. [Documentation & Developer Experience](#8-documentation--developer-experience)
9. [Open Source Sustainability](#9-open-source-sustainability)
10. [Gap Analysis](#10-gap-analysis)
11. [SWOT Analysis](#11-swot-analysis)
12. [JTBD Analysis](#12-jtbd-analysis)
13. [Threat Model Summary](#13-threat-model-summary)
14. [Risk Register](#14-risk-register)
15. [Operational Readiness Assessment](#15-operational-readiness-assessment)
16. [Scoring Summary](#16-scoring-summary)
17. [Strategic Recommendations](#17-strategic-recommendations)
18. [Prioritized Action Roadmap](#18-prioritized-action-roadmap)
19. [Final Conclusions](#19-final-conclusions)

---

## 1. Executive Summary

**What it is (fact):** PACIXP is an open-source, turnkey Internet Exchange Point (IXP) reference design targeting the Pacific Islands region. It is a documentation and configuration template project — not a software application — providing architectural blueprints, vendor-specific switch configurations (Arista EOS, Juniper QFX), route server configurations (BIRD 2.x), a containerized management stack (IXP Manager via Docker Compose), and a lab simulation environment (Containerlab).

**Maturity signal (fact/inference):** The `docs/01-high-level-design.md` is marked "Version 1.0 (Release Candidate) — Engineering Review," and `TODO.md` documents multiple blocking and high-priority gaps. The README carries a "Production Ready" badge, but this badge is inconsistent with the TODO contents and several critical defects found in review. **This project is not production-ready as-shipped.** It is a high-quality design reference with real gaps between its stated standards and its current implementation.

**Highest-value strengths:**
- Architecturally sound: EVPN/VXLAN with BGP confederation is a modern, appropriate solution for a geographically distributed IXP
- Exceptionally strong design documentation (Design Principles, HLD, Security Hardening Guide)
- MANRS alignment baked into the architecture, not bolted on
- Dual-stack by design, not by retrofit
- Fail-closed philosophy and layered security model (IRR + RPKI) are best-practice

**Most critical gaps (each evidence-based):**
1. **Security contradiction:** `strategy/virtualization.md` (line 71) documents the RPKI cache expiry behavior as "Fail Open (Warn)" while Design Principle DP-5 mandates fail-closed. This contradiction, in a document intended to guide operators, creates a live security risk if deployed.
2. **Lab non-functional:** `labs/pacixp.clabs.yml` references config files with `.conf` extension; all actual files use `.cfg` extension. Members 2–5 config files do not exist. The lab will not deploy as-written.
3. **TLS not implemented:** `templates/ixp-manager-docker-compose.yml` exposes port 443 but provides no SSL certificate volume, no certificate generation, and `docs/05-ixp-manager.md` uses `http://` in all examples. HTTPS is advertised but not configured.
4. **RPKI disabled in lab:** `labs/configs/rs1.cfg` has the RPKI protocol block commented out and uses `import all; export all;` — the exact antithesis of the security posture the project espouses.
5. **Single maintainer:** Git history shows a single committer (Terry Sweetser). Bus factor = 1.

**Commercial viability:** The CC BY-NC-SA 4.0 license with community IXP exception is well-conceived for the target audience. The commercial licensing pathway (via tcs@ieisi.org) is appropriate but entirely dependent on a single point of contact. Revenue model is implied but undocumented.

---

## 2. Repository Overview

### 2.1 Project Purpose

**(Fact)** PACIXP provides a reference architecture and operational documentation for deploying IXPs in the Pacific Islands and similar resource-constrained, geographically distributed environments. It is explicitly a template and guide, not executable software.

### 2.2 Intended Users

**(Fact, from README):**
- Network operators in Pacific Island nations (Samoa, Fiji, Tonga, Vanuatu)
- Grant funders (ISOC, APNIC) evaluating standardized deployment models
- Emerging IXPs globally seeking best-practice templates

### 2.3 Target Ecosystem

The project sits at the intersection of:
- **Internet governance** (IXP establishment, MANRS, APNIC/ISOC funding)
- **Network operations** (BGP, EVPN/VXLAN switching fabric)
- **Open source infrastructure** (IXP Manager, BIRD 2.x, Containerlab, Routinator)

### 2.4 Repository Structure Analysis

```
pacixp/
├── configs/switches/          ← Production reference configs (Arista, Juniper)
├── docs/                      ← Core design documents (Design Principles, HLD, Security, IXP Manager)
├── labs/                      ← Containerlab simulation environment
│   ├── configs/               ← Lab switch/RS/member configs
├── runbooks/                  ← Operational procedures (partial)
├── reviews/                   ← Review outputs (this review; gemini review; prompt)
├── strategy/                  ← Strategy documents (automation, onboarding, virtualization)
├── templates/                 ← Docker Compose template for IXP Manager
├── README.md                  ← Project introduction
├── TODO.md                    ← Open work items (well-maintained)
└── LICENSE.txt                ← CC BY-NC-SA 4.0 + community IXP exception
```

**Gaps in numbering (inference):** `docs/` jumps from `03-security-hardening.md` to `05-ixp-manager.md`. Document `02-addressing-plan.md` is referenced in the Arista reference config warning but does not exist. Document `04-*` is entirely absent with no explanation.

### 2.5 Language & Technology Breakdown

| Layer | Technology | Notes |
|:---|:---|:---|
| Documentation | Markdown | All docs; Mermaid diagrams embedded |
| Network OS configs | Arista EOS (`!` syntax) | Reference and lab configs |
| Network OS configs | Juniper JunOS (`set`/`{}` syntax) | Reference config only |
| Route server | BIRD 2.x config syntax | Lab and reference |
| Member BGP | FRRouting (vtysh syntax) | Lab members only |
| Container orchestration | Docker Compose YAML | IXP Manager stack |
| Lab simulation | Containerlab YAML | One topology file |
| License | CC BY-NC-SA 4.0 | Full text included |

No general-purpose programming languages (Python, Go, etc.) are present. The referenced `ixp-manager-bird-api` script is mentioned in `strategy/automation.md` but does not exist in the repository.

### 2.6 Build Systems & Deployment Models

**(Fact)** There are no build systems, CI/CD pipelines, or automated test infrastructure in this repository. Deployment is human-applied: operators read the docs, adapt the configs to their environment, and paste configurations into switch CLIs. The only automation model is the Docker Compose stack for IXP Manager.

### 2.7 External Dependencies

| Dependency | Used For | Version Pinned? | Risk |
|:---|:---|:---|:---|
| IXP Manager (`inex/ixp-manager`) | Management platform | No (`latest`) | High |
| MariaDB (`mariadb:10.6`) | Database | Yes | Low |
| Nginx (`nginx:alpine`) | Web server | No (alpine = latest) | Medium |
| Redis (`redis:alpine`) | Cache | No (alpine = latest) | Medium |
| BIRD 2.x | Route servers | `pierky/bird:2.0.8` in lab | Low |
| FRRouting (`frrouting/frr:v8.4.0`) | Lab members | Yes | Low |
| Routinator (NLnet Labs) | RPKI validator | Not pinned | Medium |
| Oxidized | Config backup | Not pinned | Medium |
| LibreNMS | Monitoring | Not pinned | Medium |
| Containerlab | Lab simulation | Not pinned | Low |
| Arista cEOS (`ceos:4.32.0F`) | Lab switches | Yes | Low |
| bgpq4 | IRR filter generation | Not in repo | High (undocumented) |

---

## 3. Engineering Assessment

### 3.1 Architecture Quality

**Rating: High** — The architectural choices are sound and well-reasoned.

The EVPN/VXLAN with BGP confederation architecture is:
- Appropriate for a geographically distributed IXP (standard industry pattern)
- Free of single points of failure at the control plane level (confederation vs route reflector)
- Consistent with Euro-IX and MANRS best practices
- Correctly decomposed into physical/underlay/overlay/management layers

Design Principle DP-1 (mirror physical to BGP topology) is an elegant constraint that dramatically simplifies troubleshooting. This is not a generic principle; it is specifically valuable in environments where engineers may have limited deep BGP expertise.

**Weakness (fact):** The architecture targets a two-site deployment. Scaling to additional sites is described in theory (HLD Section 8) but the lab only simulates a single site. No cross-site EVPN failover scenario is testable from this repo in its current state.

### 3.2 Code Quality

This project consists of configuration templates and documentation, not application code. Evaluation is on config correctness, consistency, and completeness.

**Production switch configs (arista_sw1.md, juniper_sw1.md):**
- Both are syntactically consistent with their respective platforms
- Dual-stack (IPv4 + IPv6) is correctly implemented throughout
- MTU is explicitly set (`9214` on Arista, `9216` on Juniper) per DP-11
- BGP timers are explicit (keepalive 10, hold 30) per DP-13
- ACLs `ACL-IXP-PEERING-V4` and `ACL-IXP-PEERING-V6` are both present
- `next-hop-unchanged` (Arista) / `no-nexthop-change` (Juniper) are correctly applied on inter-site sessions

**Defect:** Arista production config (`arista_sw1.md`) uses SNMPv2c (`snmp-server community PACIXP-public ro`). The community string is not a placeholder — it is literally `PACIXP-public`, making it predictable for any operator who reads this document and deploys without changing it. SNMPv3 with auth+priv is not mentioned anywhere as the preferred target configuration.

**Lab configs (sw1.cfg, sw2.cfg, rs1.cfg):**
- Lab switch configs are simplified (IPv4-only OSPF underlay, no IPv6 OSPFv3) — this is acceptable for a lab but the simplification is not documented as a deliberate deviation
- Lab sw1.cfg and sw2.cfg lack the member port security controls (storm control, BPDU guard, ACLs) present in the production reference — again undocumented as deliberate omission

**Critical lab defect (fact):** `labs/pacixp.clabs.yml` references config files with `.conf` extension:
```yaml
binds:
  - configs/rs1.conf:/etc/bird/bird.conf
  - configs/peers/member1.conf:/etc/frr/frr.conf
```
All actual files use `.cfg` extension (`rs1.cfg`, `member1.cfg`). Containerlab will fail to mount these files — the lab cannot deploy as written.

**Critical lab defect (fact):** Members 2–5 (`member2.conf` through `member5.conf`) are referenced in `pacixp.clabs.yml` but only `member1.cfg` exists in the repository.

**Lab–production addressing inconsistency (fact):** Lab `sw2.cfg` assigns `198.51.100.2/32` to the loopback. The HLD addressing plan places Site B loopbacks at `.21` (SW1) and `.22` (SW2). The production Arista reference config correctly uses `.11/.12` for Site A. The lab uses a simplified `.1/.2` scheme not aligned with the HLD. This creates risk of an operator treating the lab address plan as a production guide.

### 3.3 Modularity & Coupling

**(Fact)** The project is loosely coupled by design: documents reference each other by filename, configs reference the HLD by principle number. This is appropriate for a documentation repository. The tight coupling that exists is intentional: IXP Manager is positioned as the single source of truth (DP-3), and multiple components (BIRD, switch config generation, MRTG, PeeringDB export) are all downstream consumers of it.

**Risk (inference):** The IXP Manager coupling is operationally correct but creates a commercial dependency on the INEX-hosted Docker image (`inex/ixp-manager:latest`). There is no plan in the repository for what happens if that image is deprecated, renamed, or the upstream project changes licensing.

### 3.4 Maintainability

**Rating: Medium** — Good for a documentation project, but with sustainability risks.

Positive: The Design Principles document (DP-00) functions as an Architecture Decision Record (ADR) — it records not just decisions but the reasoning (`*Why:*` sections). This is the single most maintainability-positive element in the repository.

Negative: There are no automated consistency checks. Nothing prevents the lab configs from drifting further from the production reference. Nothing catches a documentation update that contradicts a design principle (as has already happened with the RPKI fail-open contradiction).

### 3.5 Testing & Validation

**(Fact)** There are zero automated tests. Validation is entirely manual and documented as a checklist (Section 4 of Design Principles, Section 5 of Security Hardening). The lab environment (Containerlab) provides a validation mechanism, but it is non-functional due to the `.conf`/`.cfg` extension mismatch and missing member configs.

**Critical gap:** The `README` says "all network configurations are validated against a virtual lab (e.g., GNS3, EVE-NG, or Containerlab) before submission" — but the lab itself is broken. This claim cannot be substantiated from the repository's current state.

### 3.6 CI/CD Maturity

**(Fact)** No CI/CD infrastructure exists. There is no `.github/` directory, no GitHub Actions workflows, no linting, no config validation, no link checking for documentation.

**DevOps Maturity Rating: Level 0** (no automation).

### 3.7 Anti-Patterns Identified

| Anti-Pattern | Evidence | Severity |
|:---|:---|:---|
| `latest` Docker image tags | `inex/ixp-manager:latest`, `nginx:alpine`, `redis:alpine` | High |
| Credential in CLI argument | `mysqldump -u ixp -pPASSWORD ixp` in `strategy/automation.md` | High |
| Plaintext credentials in config | Oxidized config: `password: your_ssh_password` | High |
| `.conf` vs `.cfg` extension mismatch | lab clabs.yml vs actual files | Critical |
| Missing files referenced in topology | member2–5 configs | Critical |
| RPKI protocol commented out in lab | `rs1.cfg` | Critical |
| Fail-open documented despite fail-closed mandate | `strategy/virtualization.md` line 71 | Critical |
| HTTP instead of HTTPS in deployment guide | `docs/05-ixp-manager.md` | High |
| No TLS config despite port 443 exposure | `templates/ixp-manager-docker-compose.yml` | High |
| RFC1918 addresses in a runbook | `runbooks/ixp-manager-arista-switch.md` sFlow config | Medium |
| Predictable SNMP community string | `PACIXP-public` in both arista configs | Medium |

---

## 4. Security Review

### 4.1 Attack Surface

The production attack surface is well-reasoned in the design. Member-facing ports have seven mandatory controls (DP-6). Route servers have layered filtering. Management is physically isolated. The design philosophy is sound.

**However, the implementation artifacts (configs, templates) introduce specific vulnerabilities:**

### 4.2 Critical Security Finding: RPKI Fail-Open Contradiction

**(Fact)** `strategy/virtualization.md`, Section 5 "Critical Interaction Flows", Flow 2 (RPKI Validation), states:

> "After that, it fails open (allows all) or fails closed (blocks all) depending on config. *PACIXP Default: Fail Open (Warn).*"

Design Principle DP-5 explicitly prohibits this:

> "RPKI cache expiry: route servers must reject or hold routes rather than accepting them as valid."

This is a direct contradiction in the same repository. An operator following `strategy/virtualization.md` would deploy a fail-open RPKI configuration, violating both DP-5 and MANRS Action 1. The TODO.md acknowledges this as a blocking item. It remains unresolved.

**STRIDE Analysis:**
- **Spoofing:** A member (or attacker impersonating a member AS) could announce RPKI-invalid routes during a Routinator outage window and have them propagated — if the fail-open configuration is in place
- **Tampering:** IRR filters provide partial mitigation only (they catch routes outside the AS-SET, not RPKI-invalid routes within it)
- **Elevation of Privilege:** Propagation of invalid routes to all IXP members effectively elevates attacker routing influence

### 4.3 Security Finding: No TLS on IXP Manager

**(Fact)** `templates/ixp-manager-docker-compose.yml` binds port 443:
```yaml
ports:
  - "80:80"
  - "443:443"
```
But there is:
- No SSL certificate volume defined
- No Nginx TLS configuration provided
- `docs/05-ixp-manager.md` sets `APP_URL=http://ixp.pacixp.net` (HTTP, not HTTPS)

The IXP Manager portal contains member credentials, BGP session data, and switch access information. Operating it over HTTP exposes this data to any network path between the operator's browser and the server.

**STRIDE:** Tampering/Information Disclosure — member data, admin credentials, and BGP configs in transit can be intercepted and modified.

### 4.4 Security Finding: Credential Exposure

**(Fact)** `strategy/automation.md` documents this backup cron:
```bash
docker exec ixp-manager-db-1 mysqldump -u ixp -pPASSWORD ixp > /backups/ixp_$(date +\%H).sql
```

The password is inline on the command line. On Linux, command line arguments are visible to any process that can read `/proc/<pid>/cmdline` during execution, and to any user who runs `ps aux`. This is a textbook credential exposure pattern.

**Additionally (fact):** The Oxidized config in `strategy/automation.md` stores switch credentials in plaintext YAML:
```yaml
groups:
  arista:
    username: admin
    password: your_ssh_password
```

There is no mention of secret management tooling (HashiCorp Vault, Docker secrets, environment variable injection at runtime) anywhere in the repository.

### 4.5 Security Finding: SNMPv2c with Predictable Community String

**(Fact)** Both `configs/switches/arista_sw1.md` and `runbooks/ixp-manager-arista-switch.md` use the community string `PACIXP-public`. This string:
- Is not marked as a placeholder requiring replacement
- Is the same across both documents
- Is predictable to anyone who reads this open-source repository
- Grants read-only SNMP access to switch OIDs including interface counters, routing tables, and system information

SNMPv3 with authentication and privacy is not mentioned as a target configuration.

### 4.6 Security Finding: Lab Route Server Has No Security Filtering

**(Fact)** `labs/configs/rs1.cfg`:
- RPKI protocol block is commented out entirely
- Template uses `import all; export all;`
- Comments acknowledge this: "# In production: apply RPKI, IRR, bogon, and max-prefix filters"

While this is labeled "LAB ONLY," the lab is specifically designed for operators to validate the architecture before production deployment. An operator learning on this lab will learn that route servers accept and export everything. The correct pattern would be to have the lab demonstrate production-realistic filtering with placeholder data.

### 4.7 MITRE ATT&CK Relevant Techniques

| Technique | Applicability | Mitigation Status |
|:---|:---|:---|
| T1499 (Endpoint DoS via network) | MAC flood, storm control evasion | Mitigated by design; controls in production config |
| T1557 (Adversary-in-the-Middle via BGP hijack) | Route injection by misbehaving member | Partially mitigated (IRR/RPKI design); fail-open risk |
| T1110 (Credential Access via brute force) | SSH to switches/servers | Mitigated: SSH key-only auth documented |
| T1078 (Valid Accounts) | Stolen admin credentials | Partial: MFA not mentioned; plaintext credential risk |
| T1190 (Exploit Public-Facing Application) | IXP Manager web portal | Unmitigated: HTTP, no mention of WAF |

### 4.8 Supply Chain Risk

- `inex/ixp-manager:latest` is pulled from Docker Hub at deploy time with no version pinning or image digest pinning. A compromised or changed `latest` tag would be silently deployed.
- `bgpq4` (IRR filter generation) is referenced as a dependency but is not installed as part of any documented procedure; its provenance and version are entirely opaque.

### 4.9 Trust Boundaries

| Boundary | Implemented? | Status |
|:---|:---|:---|
| Member port isolation (L2) | Yes — design | Strong |
| Management plane isolation | Yes — design | Strong (if OOB is physically separate) |
| Route server → IXP Manager trust | Partial | RS has SSH access to push configs; scope not bounded |
| IXP Manager → switches trust | Partial | SNMP community string; no per-device auth |
| Internet → IXP Manager portal | Weak | No TLS, no WAF, no rate limiting documented |

---

## 5. Product & Market Review

### 5.1 Jobs To Be Done (JTBD) Analysis

**Primary Functional Job:**
> "When I need to establish an IXP in a Pacific Island nation with limited local expertise and budget, help me deploy a modern, secure, interoperable exchange fabric that keeps local traffic local."

**Secondary Functional Jobs:**
- Obtain grant funding by demonstrating a standardized, auditable design
- Onboard ISP members with minimal friction
- Maintain MANRS compliance to qualify for ISOC/APNIC recognition programs
- Scale the exchange to additional island sites without redesigning the fabric

**Social Jobs:**
- Signal technical credibility to regional and international peers
- Demonstrate that the Pacific Islands can operate modern Internet infrastructure without external consultants
- Build a community of practice among Pacific Island network operators

**Emotional Jobs:**
- Give local operators confidence that they can troubleshoot at 2am during a cable cut (DP-8's explicit design motivation)
- Reduce anxiety about making a catastrophic configuration mistake (human-in-the-loop automation, quarantine VLANs, generate-and-apply model)

**Ecosystem Jobs:**
- Contribute to the global routing security ecosystem (MANRS, RPKI, IRR accuracy)
- Feed accurate data to PeeringDB and IX-F
- Enable Pacific Island ISPs to reduce transit costs and improve resilience

### 5.2 Product-Market Fit Indicators

**Positive:**
- The Pacific Islands have documented IXP establishment challenges; PACIXP addresses a real unmet need
- APNIC and ISOC have funded IXP development in the region; a standardized reference design aligns with their programmatic interests
- The target audience (small teams, limited resources) is well-served by the "generate and apply" automation philosophy

**Negative/Unknown:**
- No evidence of existing deployments, user testimonials, or adoption data in the repository
- The "Production Ready" badge on README is inconsistent with the TODO.md; if adopted as-is by an operator, it would create a false sense of readiness

### 5.3 Competitive Positioning

**(Inference)** The primary "competition" is:
1. **Consulting-led bespoke deployments** — PACIXP offers standardization; consultants offer customization
2. **Other IXP reference designs** (Euro-IX has published some materials) — PACIXP's differentiation is Pacific-specific context (submarine cable resilience, island site topology, resource constraints)
3. **Generic IXP Manager documentation** — PACIXP wraps IXP Manager in a complete architecture, not just a software deployment guide

**Strategic defensibility (inference):** Low-to-medium. The architectural patterns are not proprietary; Arista and Juniper publish their EVPN docs. The differentiation is in the integration, the Pacific-specific context, and the community trust the project builds.

### 5.4 Adoption Friction Analysis

| Friction Point | Severity | Evidence |
|:---|:---|:---|
| Lab non-functional out of the box | High | `.conf`/`.cfg` mismatch, missing member configs |
| No HTTPS on management portal | High | `http://` in all examples |
| No automated provisioning of RIR resources | Medium | DP-12 directs operators to APNIC, but there's no workflow integration |
| No BOM or hardware cost guidance | Medium | TODO.md notes this |
| RPKI contradiction may mislead operators | High | Virtualization doc contradicts design principles |
| Missing `docs/02-addressing-plan.md` | Medium | Referenced but absent |

---

## 6. Governance & Organizational Review

### 6.1 Project Governance

**(Fact)** The project is governed by a single individual: Terry Sweetser, `tcs@ieisi.org`, IEISI.ORG. This is evident from:
- Git author: "Terry Sweetser" (sole committer in visible history)
- Copyright: "Copyright (c) 2026 Terry Sweetser, IEISI.ORG"
- Commercial licensing contact: `tcs@ieisi.org`
- NOC contact: `noc@pacixp.net` (organization email, but no team behind it documented)

**Bus Factor: 1** — If Terry Sweetser is unavailable, no one else is documented to have decision authority, commit access, or commercial licensing authority.

### 6.2 Contribution Model

**(Fact)** Contributing guidelines exist only in `README.md`:
- Fork → feature branch → PR
- Configs must be validated in a virtual lab before submission

There is no:
- `.github/CONTRIBUTING.md`
- `.github/ISSUE_TEMPLATE/`
- `.github/PULL_REQUEST_TEMPLATE.md`
- Code of Conduct
- Documented review process (who reviews PRs? What is the standard?)

### 6.3 Decision Transparency

**(Positive fact)** The Design Principles document (`docs/00-design-principles.md`) is an exemplar of documented decision-making. Each principle includes not just the rule but the rationale, and Section 3 ("Anti-Patterns") explicitly documents rejected approaches and why they were rejected. This is governance-quality documentation.

**(Gap)** There is no governance document for the *project itself* (who can approve PRs, how disputes are resolved, how design principles are amended, what constitutes a breaking change).

### 6.4 Policy & Standards Review

| Policy | Status |
|:---|:---|
| Security policy | Absent (no `SECURITY.md`, no vulnerability disclosure process) |
| Code of conduct | Absent |
| License | Present and detailed (CC BY-NC-SA 4.0 + community exception) |
| Commercial licensing terms | Referred to tcs@ieisi.org — not published |
| MANRS alignment | Documented and thorough |
| Change evaluation checklist | Present (Section 4 of Design Principles) |

### 6.5 Governance Maturity Assessment

**Rating: Low-Medium** — Excellent technical governance (design principles, anti-patterns, checklists), weak organizational governance (no succession plan, no contribution process, no security disclosure path).

---

## 7. Infrastructure & Operational Review

### 7.1 Deployment Architecture

| Layer | Design | Actual State |
|:---|:---|:---|
| Switching fabric | 2x Arista or Juniper per site | Template only; no deployment automation |
| Route servers | 2x active-active BIRD 2.x VMs | Template only; install process in HLD |
| Management stack | Docker Compose on Proxmox VM | Docker Compose template present; no Proxmox config |
| Monitoring | LibreNMS + Oxidized | Referenced; no deployment runbook |
| Backup | Oxidized (switch), mysqldump (DB) | Scripts not in repo; cron line in strategy doc |

### 7.2 Operational Readiness Indicators

| Indicator | Status | Notes |
|:---|:---|:---|
| OOB management design | Documented | Strong (DP-7) |
| UPS requirement | Documented | Section 9 of HLD |
| Upgrade procedures | **Missing** | TODO.md: High Priority |
| Backup/restore procedures | **Missing** | TODO.md: High Priority |
| Zero-downtime switch maintenance | **Missing** | TODO.md: High Priority |
| Incident response contacts | Placeholder | `+679-XXX-XXXX` |
| SLA definitions | **Missing** | TODO.md: Low Priority |
| Member support matrix | Present | Onboarding doc |
| Failure scenario documentation | Present | HLD Section 7 |

### 7.3 Monitoring Maturity

**(Fact)** The monitoring design mentions:
- LibreNMS for SNMP/sFlow collection
- IXP Manager for BGP session state
- Smokeping for member latency
- Oxidized for config diff/backup

However:
- Alert thresholds are documented as missing (TODO.md)
- No Prometheus/Alertmanager/Grafana stack is mentioned — standard in 2025+ for network operations
- SNMP version is v2c (legacy); no mention of streaming telemetry (gNMI/gRPC) which Arista cEOS supports

### 7.4 Proxmox as Hypervisor

**(Observation)** `strategy/virtualization.md` specifies Proxmox VE as the hypervisor. This is a reasonable choice for community-operated infrastructure. However, there are no Proxmox configuration templates, no VM provisioning automation, and no documented Proxmox version or configuration requirements in the repository.

### 7.5 Recovery Time Objectives

| Scenario | Documented RTO | Confidence |
|:---|:---|:---|
| RS1 failure | Instant (RS2 continues) | High — architectural |
| Management VM failure | < 15 minutes (manual) | Medium — assumes ZFS replication works |
| Total site power loss | BGP reconnect time | Medium — assumes proper boot ordering |
| IXP Manager DB loss | Unknown | Low — no restore runbook |

---

## 8. Documentation & Developer Experience

### 8.1 Documentation Quality Assessment

| Document | Quality | Notes |
|:---|:---|:---|
| `docs/00-design-principles.md` | **Excellent** | Best document in repo; ADR-quality |
| `docs/01-high-level-design.md` | **Good** | Clear, Mermaid diagrams, good failure analysis |
| `docs/03-security-hardening.md` | **Good** | MANRS-aligned, checklist present |
| `docs/05-ixp-manager.md` | **Fair** | Missing TLS, uses HTTP |
| `strategy/automation.md` | **Fair** | Credential exposure in example; Oxidized config has plaintext passwords |
| `strategy/onboarding.md` | **Good** | Multi-vendor config snippets, clear workflow |
| `strategy/virtualization.md` | **Fair** | RPKI contradiction is dangerous |
| `labs/README.md` | **Poor** | Only 30 lines; lab is broken |
| `runbooks/ixp-manager-arista-switch.md` | **Good** | Clear step-by-step |
| `README.md` | **Good** | Clear project overview; "Production Ready" badge misleading |
| `TODO.md` | **Good** | Well-maintained, categorized by priority |

### 8.2 Documentation Gaps

| Missing Document | Impact |
|:---|:---|
| `docs/02-addressing-plan.md` | Referenced in Arista config; operators have no IP worksheet |
| `docs/04-*.md` | Gap in document numbering; unknown content |
| Backup/restore runbook | High — no DB recovery procedure |
| Zero-downtime upgrade guide | High — no maintenance window procedure |
| `SECURITY.md` (vulnerability disclosure) | High — no way to report security issues |
| `CONTRIBUTING.md` (standalone) | Medium — only embedded in README |
| Bill of Materials | Medium — no hardware procurement guidance |
| Proxmox setup guide | Medium — virtualization strategy references it but no config |
| BGP community policy | Medium — mentioned but not defined |

### 8.3 Hidden/Tribal Knowledge

The following is known to the author but not documented in the repository:
- How to obtain and import the Arista cEOS image for Containerlab (labs/README.md mentions this as a TODO)
- Commercial licensing terms (email only)
- How `bgpq4` is installed, configured, or integrated with IXP Manager
- What version of Proxmox is required or recommended
- What the actual PACIXP NOC phone number is (placeholder `+679-XXX-XXXX`)

---

## 9. Open Source Sustainability

### 9.1 Contributor Diversity

**(Fact)** Single committer in visible git history. The project appears to be a one-person effort. No evidence of external contributions.

### 9.2 Activity Patterns

**(Fact, from git log excerpts visible in session context):**
- Recent commits show active development (code review integration, TODO completion items)
- The project appears to be in active development, not abandoned

### 9.3 Funding & Sustainability

**(Fact)** A `FUNDING.yml` exists (referenced in recent git commits: "Update thanks_dev URL format in FUNDING.yml"). The CC BY-NC-SA 4.0 license creates a commercial licensing pathway via IEISI.

**(Inference)** The project's financial sustainability is unclear. There is no mention of existing paying commercial licensees, grant funding received, or a revenue roadmap. The community IXP exception means the primary beneficiaries (non-profit Pacific IXPs) pay nothing. Commercial revenue depends entirely on for-profit entities who need a separate license — a potentially small addressable market.

### 9.4 Existential Risks

| Risk | Probability | Impact |
|:---|:---|:---|
| Maintainer unavailability | Medium (single person) | Critical |
| Upstream IXP Manager project changes | Low | High |
| Arista/Juniper API/config changes | Low | Medium |
| Grant funding dependency failure | Unknown (grants not confirmed) | High |
| License ambiguity for edge cases | Low | Medium |

### 9.5 License Analysis

**(Fact)** The CC BY-NC-SA 4.0 license is well-suited for documentation and configuration templates. The community IXP exception in `LICENSE.txt` is a custom grant, legally speaking — it modifies CC BY-NC-SA by allowing commercial use for a defined class of entities (community IXPs). This is valid but creates an ambiguity: "cost-recovery fees" vs. "commercial advantage" is not always clearly delineated. A for-profit ISP that operates a community IXP program as a loss-leader might claim the exception.

**(Recommendation, not a fact):** The commercial/community distinction should be tested with legal counsel before commercial licensing enforcement.

---

## 10. Gap Analysis

### 10.1 Current vs. Production-Ready

| Capability | Current State | Production-Ready State | Gap | Urgency |
|:---|:---|:---|:---|:---|
| TLS for management portal | Not implemented | Mandatory | Critical | Blocking |
| RPKI fail-closed | Contradicted in docs | Mandatory | Critical | Blocking |
| Lab functional | Broken | Required for validation claims | Critical | Blocking |
| Backup/restore procedures | Missing | Required | High | Pre-launch |
| Upgrade procedures | Missing | Required | High | Pre-launch |
| Alert thresholds | Missing | Required | High | Pre-launch |
| SNMPv3 | Not configured | Best practice | Medium | 30-90 days |
| Credential management | Plaintext in docs | Secret management tool | Medium | 30 days |
| IPv6 RS sessions in lab | Not configured | Required for dual-stack validation | High | 30 days |

### 10.2 Current vs. Enterprise-Ready

| Capability | Gap | Complexity |
|:---|:---|:---|
| Ansible/NETCONF automation for switches | Missing | High |
| Streaming telemetry (gNMI) | Not mentioned | High |
| MFA for management access | Not mentioned | Medium |
| WAF / rate limiting on portal | Not mentioned | Medium |
| Formal SLA documentation | Missing | Low |
| Configuration drift detection | Partial (Oxidized) | Low |

### 10.3 Current vs. Carrier-Grade

| Capability | Gap |
|:---|:---|
| 99.9%+ uptime SLA | Not defined |
| BFD for sub-second failure detection | Mentioned in DP-13 as optional; no config provided |
| Multi-vendor management plane | IXP Manager is the only IPAM; no fallback |
| Formal change management process | Not documented |

### 10.4 Current vs. Security Best Practice

| Gap | Description | Urgency |
|:---|:---|:---|
| TLS everywhere | IXP Manager over HTTP | Critical |
| No secret management | Plaintext credentials in docs and configs | High |
| SNMPv2c → SNMPv3 | Community string authentication only | High |
| RPKI fail-closed implementation | Documented as fail-open | Critical |
| Vulnerability disclosure process | No SECURITY.md | Medium |
| Container image pinning | Several `:latest` tags | High |

---

## 11. SWOT Analysis

### Strengths
- **Architectural excellence:** The EVPN/BGP confederation design is modern, scalable, and appropriate for the use case
- **Documentation depth:** Design Principles doc is ADR-quality and operationally pragmatic
- **MANRS/Standards alignment:** Security compliance is built into the architecture, not added after
- **Dual-stack by design:** Correct and forward-looking
- **Local survivability design (DP-4):** Directly addresses the primary operational risk (submarine cable outages)
- **Appropriate automation philosophy:** "Generate and apply" is correct for a small team; avoids automation accidents

### Weaknesses
- **Bus factor = 1:** Single maintainer
- **Lab is non-functional:** Undercuts the validation claims
- **Critical security contradictions:** RPKI fail-open documented despite fail-closed mandate
- **No TLS:** Management portal HTTP-only in all templates
- **No CI/CD:** No automated validation of any kind
- **Missing critical documents:** Backup runbook, upgrade guide, addressing plan, `SECURITY.md`
- **Predictable SNMP community string:** `PACIXP-public` in production templates

### Opportunities
- **Grant alignment:** APNIC/ISOC fund IXP development; this is a natural grant proposal asset
- **Euro-IX and NSRC partnership:** Established technical bodies could amplify adoption and contribute reviewers
- **Training curriculum integration:** APNIC Academy could reference this design in BGP/IXP courses
- **Containerlab ecosystem:** The lab environment positions the project well for hands-on training workshops
- **MANRS IXP Programme:** Formal MANRS recognition would be a powerful endorsement

### Threats
- **Adoption-before-maturity risk:** The "Production Ready" badge may lead operators to deploy before critical gaps are closed, damaging trust in the project
- **Upstream dependency changes:** IXP Manager, BIRD, or Arista cEOS may change in ways that break templates
- **Single-point-of-failure governance:** If IEISI.ORG becomes inactive, the project has no formal continuation mechanism
- **License enforcement ambiguity:** Community vs. commercial boundary may create disputes
- **Competitor reference designs:** Euro-IX or NSRC could publish competing templates with more organizational backing

---

## 12. JTBD Analysis

*(See Section 5.1 for the full JTBD treatment; summarized here.)*

| Job Type | Job Statement | Current Fulfillment |
|:---|:---|:---|
| Functional | Deploy a modern IXP fabric with limited expertise | Partial — design is excellent; lab is broken |
| Functional | Demonstrate MANRS compliance for grant applications | Strong — MANRS alignment is thorough |
| Functional | Onboard members with minimal friction | Good — onboarding guide is detailed |
| Functional | Scale to additional island sites | Documented in theory; no multi-site lab |
| Social | Signal technical credibility | Strong — design quality supports this |
| Social | Enable local self-sufficiency | Good — "generate and apply" model supports local ops |
| Emotional | Confidence to troubleshoot at 2am | Strong — DP-8, operational drills, troubleshooting matrix |
| Ecosystem | Feed accurate data to PeeringDB/IX-F | Strong — IXP Manager integration documented |
| Ecosystem | Contribute to global routing security | Strong — RPKI/IRR model is correct (if deployed correctly) |

---

## 13. Threat Model Summary

**Threat Actors (inference, based on IXP context):**

| Actor | Capability | Motivation |
|:---|:---|:---|
| Misbehaving IXP member (accidental) | Low | Misconfiguration floods, STP leakage |
| Misbehaving IXP member (deliberate) | Low-Medium | Route hijack, traffic disruption |
| External BGP attacker | Medium | Exploit RPKI/IRR gaps if fail-open |
| Insider (compromised operator account) | High | Full fabric control |
| Supply chain attacker | Medium | Compromise Docker images |

**STRIDE Summary:**

| STRIDE Element | Status |
|:---|:---|
| **Spoofing** | Mitigated at L2 (MAC locking, port security); partial at L3 (RPKI/IRR); weak at management layer (HTTP portal) |
| **Tampering** | Mitigated by OOB management, key-only SSH; risk in HTTP portal for config changes |
| **Repudiation** | Syslog collection documented; no SIEM or log integrity mechanism |
| **Information Disclosure** | HTTP portal exposes member and config data; plaintext SNMP; Oxidized stores credentials |
| **Denial of Service** | Well-mitigated at member port level (storm control, BPDU guard, max-prefix); no CoPP config shown |
| **Elevation of Privilege** | RS has SSH access to push configs; no documented least-privilege model for IXP Manager → RS communication |

---

## 14. Risk Register

| ID | Risk | Likelihood | Impact | Current Mitigation | Residual Risk |
|:---|:---|:---|:---|:---|:---|
| R01 | RPKI fail-open deployed (virtualization.md contradicts DP-5) | High | Critical | TODO.md acknowledges; not fixed | Critical |
| R02 | Lab deployed by operator as-is; fails silently | High | High | "LAB ONLY" comment | High |
| R03 | IXP Manager portal accessible over HTTP | High | High | None | High |
| R04 | Credentials in command-line/config files | High | High | None | High |
| R05 | `latest` Docker image deployed; upstream change breaks deployment | Medium | High | None | High |
| R06 | Single maintainer unavailability | Medium | Critical | None | Critical |
| R07 | SNMP community string `PACIXP-public` deployed unchanged | Medium | Medium | TODO warning note | Medium |
| R08 | Missing member configs block lab | High | Medium | TODO.md | Medium |
| R09 | Addressing plan document missing | Medium | Medium | HLD has address table | Medium |
| R10 | No backup/restore procedure | Medium | High | Strategy doc mentions; no runbook | High |
| R11 | No upgrade procedure for BIRD/IXP Manager | Medium | High | None | High |
| R12 | IXP Manager upstream project lifecycle risk | Low | High | None | Medium |

---

## 15. Operational Readiness Assessment

| Dimension | Score (1–5) | Justification |
|:---|:---|:---|
| Day-1 deployment readiness | 2 | TLS missing, RPKI contradiction, lab broken |
| Day-2 operations readiness | 2 | No backup runbook, no upgrade guide, no alert thresholds |
| Incident response readiness | 2 | Placeholder contacts, no CERT escalation path defined |
| Member onboarding readiness | 4 | Onboarding guide is detailed and well-structured |
| Monitoring readiness | 3 | Architecture documented; tooling not deployed or configured |
| Security posture | 3 | Design is strong; implementation artifacts undermine it |
| Documentation completeness | 3 | Core docs excellent; operational runbooks sparse |

**Operational Readiness Verdict:** Not ready for production without closing the critical gaps listed in the TODO and identified in this review. The architecture is production-grade; the deployment artifacts are not.

---

## 16. Scoring Summary

**Scoring Model:** 1–5 maturity scale
- 1 = Not present / prototype
- 2 = Partial / significant gaps
- 3 = Functional with known limitations
- 4 = Production-quality with minor gaps
- 5 = Best-in-class

| Dimension | Score | Justification |
|:---|:---|:---|
| **Engineering Quality** | 3.5 | Architecture is excellent (5); implementation artifacts have critical defects (2) |
| **Maintainability** | 3 | Design principles are ADR-quality; no CI, no automated consistency checks |
| **Scalability** | 4 | BGP confederation scales as O(sites); design explicitly plans for new sites |
| **Operational Readiness** | 2 | Missing backup, upgrade, incident response runbooks; broken lab |
| **Governance Maturity** | 2 | Excellent technical governance (design principles); weak organizational governance |
| **Security Posture** | 2.5 | Design is strong; RPKI contradiction, no TLS, credential exposure undermine it |
| **Documentation Quality** | 3.5 | Core docs excellent; operational runbooks sparse; critical docs missing |
| **Ecosystem Readiness** | 3 | MANRS/IXP Manager integration well-conceived; no adoption evidence |
| **Commercial Viability** | 2.5 | License model is appropriate; single-person operation limits scale |
| **Sustainability** | 2 | Bus factor 1; no community governance; funding model unclear |

**Overall Composite Score: 2.8 / 5 — "Functional Reference Design, Not Yet Production-Ready"**

---

## 17. Strategic Recommendations

### Engineering

**Immediate:**
1. Fix the `.conf` / `.cfg` extension mismatch in `labs/pacixp.clabs.yml` — the lab is the primary validation tool
2. Create `labs/configs/peers/member2.cfg` through `member5.cfg` to make the lab deployable
3. Add the IPv6 address to the `rs1` node in `labs/pacixp.clabs.yml`
4. Enable and configure the RPKI protocol block in `labs/configs/rs1.cfg` (even with a comment-only Routinator)
5. Add basic bogon filtering to the lab RS config to demonstrate production patterns

**Short-term:**
6. Add Nginx TLS configuration to `templates/ixp-manager-docker-compose.yml` with Certbot/Let's Encrypt instructions
7. Pin all Docker image tags to specific versions with SHA digests
8. Add IPv6 BGP sessions to `labs/configs/rs1.cfg` for dual-stack validation

**Medium-term:**
9. Add GitHub Actions workflows: Markdown linting, YAML validation, broken link checking
10. Create `docs/02-addressing-plan.md` with the IP allocation worksheet

### Security

**Immediate:**
1. Resolve the RPKI fail-open/fail-closed contradiction in `strategy/virtualization.md` — change to "Fail Closed" to match DP-5
2. Replace inline password in mysqldump cron with a `.my.cnf` credential file or Docker secret
3. Remove plaintext passwords from Oxidized config example; replace with reference to a secret management approach
4. Change the `APP_URL` in `docs/05-ixp-manager.md` to `https://`; add TLS setup instructions

**Short-term:**
5. Create `SECURITY.md` with a vulnerability disclosure process and contact
6. Add SNMPv3 configuration to the Arista and Juniper reference configs as the recommended target
7. Document secret management (Docker secrets, or at minimum `.env` file with restricted permissions) for all credential-bearing configs

### Governance

**Immediate:**
1. Create `SECURITY.md`
2. Create `.github/CONTRIBUTING.md` with reviewer expectations and PR requirements
3. Create `.github/ISSUE_TEMPLATE/` with bug and feature request templates

**Short-term:**
4. Document a succession/stewardship plan — who would maintain the project if IEISI becomes inactive
5. Establish a technical advisory group (even informal) of Pacific Island network operators

**Medium-term:**
6. Engage Euro-IX or NSRC for formal endorsement or co-maintenance
7. Apply for MANRS IXP Programme recognition for the design itself

### Operations

**Immediate:**
1. Create a backup/restore runbook (IXP Manager DB + Oxidized + volumes)
2. Replace `+679-XXX-XXXX` placeholders with real NOC contact information or an explicit placeholder instruction

**Short-term:**
3. Create a zero-downtime upgrade runbook for BIRD and IXP Manager
4. Document BGP session flap alert thresholds for LibreNMS

### Documentation

**Immediate:**
1. Remove or qualify the "Production Ready" badge on README — it is inconsistent with `TODO.md`
2. Create `docs/02-addressing-plan.md`

**Medium-term:**
3. Create `BOM.csv` with hardware recommendations
4. Expand `labs/README.md` with `containerlab destroy` instructions and cEOS import guidance

---

## 18. Prioritized Action Roadmap

### Week 1 (Critical / Blocking)

| # | Action | Owner Domain | Impact |
|:---|:---|:---|:---|
| 1 | Fix `.conf`/`.cfg` extension mismatch in clabs.yml | Engineering | Lab becomes deployable |
| 2 | Create member2–5 `.cfg` files in labs/configs/peers/ | Engineering | Lab becomes deployable |
| 3 | Fix RPKI fail-open in `strategy/virtualization.md` | Security | Removes dangerous contradiction |
| 4 | Add IPv6 addr to rs1 node in clabs.yml | Engineering | IPv6 sessions become testable |
| 5 | Add TLS/HTTPS to IXP Manager Docker template and docs | Security | Eliminates plaintext credential exposure |

### Month 1 (High Priority / Pre-Launch)

| # | Action | Owner Domain | Impact |
|:---|:---|:---|:---|
| 6 | Enable RPKI in lab rs1.cfg; add basic filtering | Security | Lab reflects production security posture |
| 7 | Create `SECURITY.md` | Governance | Enables responsible disclosure |
| 8 | Pin all Docker image tags | Security | Eliminates supply chain risk |
| 9 | Replace inline passwords with credential files | Security | Eliminates credential exposure |
| 10 | Create backup/restore runbook | Operations | Closes high-priority TODO |
| 11 | Create `docs/02-addressing-plan.md` | Documentation | Closes referenced missing document |
| 12 | Add IPv6 BGP sessions to lab rs1.cfg | Engineering | Dual-stack validation |

### Month 2–3 (Medium Priority)

| # | Action | Owner Domain | Impact |
|:---|:---|:---|:---|
| 13 | Add GitHub Actions (lint, YAML validate, link check) | DevOps | Automated consistency checking |
| 14 | Create zero-downtime upgrade runbook | Operations | Closes high-priority TODO |
| 15 | Add SNMPv3 config to reference configs | Security | Removes legacy credential risk |
| 16 | Create CONTRIBUTING.md and issue templates | Governance | Enables community contribution |
| 17 | Add alert threshold documentation | Operations | Closes monitoring gap |
| 18 | Remove "Production Ready" badge or qualify it | Documentation | Prevents misleading operators |

### Quarter 2–4 (Strategic)

| # | Action | Owner Domain | Impact |
|:---|:---|:---|:---|
| 19 | Establish technical advisory group | Governance | Reduces bus factor risk |
| 20 | Apply for MANRS IXP Programme endorsement | Ecosystem | Credibility and discoverability |
| 21 | Engage APNIC/ISOC for grant-funded continuation | Commercial | Financial sustainability |
| 22 | Multi-site lab scenario (Site A + Site B) | Engineering | Validates the distributed design |
| 23 | Ansible automation phase (switch config push) | Engineering | Moves from "Walk" to "Run" automation |

---

## 19. Final Conclusions

PACIXP is an architecturally mature, technically well-conceived reference design for a class of IXPs that are critically underserved: small, geographically distributed exchanges in the Pacific Islands operating with limited budgets and small technical teams. The core architectural decisions — EVPN/VXLAN with BGP confederation, fail-closed RPKI, layered IRR/RPKI filtering, OOB management isolation, and human-in-the-loop automation — are all correct and appropriate. The Design Principles document is genuinely exceptional: it reads like an ADR (Architecture Decision Record) of the kind that only experienced engineers produce.

**However, the project currently overstates its readiness.** The "Production Ready" badge is inconsistent with the facts: the lab environment cannot be deployed as shipped, the most critical security property (RPKI fail-closed) is contradicted in one of the design documents, and the management portal has no TLS configuration. If an operator reads the documentation and deploys this design without careful cross-referencing, they could end up with an IXP manager running over HTTP and a route server configured to fail-open on RPKI cache expiry — the exact opposite of what the design principles mandate.

**The gap between design quality and implementation completeness is the central finding of this review.** The design earns a 4.5/5; the implementation artifacts as shipped earn a 2/5. The overall score of 2.8 reflects this gap. Closing the critical items identified in this review — which are largely documentation corrections, lab file fixes, and TLS configuration — would push the project to a 4/5 overall within weeks.

**For board-level or investor evaluation:** This project represents a genuine infrastructure contribution to the Pacific Internet ecosystem. It has strategic alignment with APNIC, ISOC, and MANRS programs. Its weaknesses are fixable and mostly related to completeness, not correctness. The single-maintainer sustainability risk is the most significant long-term concern and warrants governance structure investment before the project attracts operational deployments.

**For technical due diligence (adopting IXPs):** Do not deploy based on the current `Production Ready` claim. Close the critical gaps (RPKI contradiction, TLS, lab fixes) before any production rollout. The architecture is sound; the deployment artifacts need hardening.

---

*This review was conducted in read-only mode. No files were modified. All findings are derived from direct observation of repository contents. Speculation and inference are labeled throughout.*

---

`★ Insight ─────────────────────────────────────`
The most revealing analysis technique used here was **cross-file consistency checking**: comparing what `strategy/virtualization.md` says RPKI does at cache expiry (fail-open) against what `docs/00-design-principles.md` DP-5 mandates (fail-closed). This contradiction could not be found by reading either file in isolation — only by holding both in view simultaneously. This is why code reviews of documentation repositories benefit from the same rigor as code reviews of software: the "logic bugs" are in the prose.
`─────────────────────────────────────────────────`
