Based on a verification-focused review of the PACIXP repository, the following findings identify contradictions, broken references, and security gaps between the project's design principles and its implementation artifacts.

## Findings List

[SEVERITY: Critical]
[TYPE: Contradiction]
File: `docs/00-design-principles.md`:145 vs `strategy/virtualization.md`:81
Finding: The project core principles mandate a "Fail-Closed" RPKI policy, but the virtualization strategy specifies "Fail-Open (Warn)" as the default implementation.
Evidence: DP-5 states "Fail-Closed... RPKI fail-closed eliminates [the window of risk]" while `virtualization.md` states "PACIXP Default: Fail Open (Warn)."
Impact: In the event of an RPKI validator outage, the IXP will silently accept invalid routes, directly violating DP-5 and MANRS Action 3.
Fix: Update `strategy/virtualization.md` to specify "Fail-Closed" and ensure BIRD templates reflect this behavior.

[SEVERITY: Critical]
[TYPE: Broken Reference]
File: `README.md`:105, `docs/00-design-principles.md`:242, `configs/switches/arista_sw1.md`:16
Finding: The `docs/02-addressing-plan.md` file is referenced as a foundational dependency for deployment but is missing from the repository.
Evidence: `README.md` instructs to "Review the High Level Design... and 02-addressing-plan.md" but the file does not exist in `docs/`.
Impact: Operators cannot validate infrastructure or peering IP assignments against the intended master design.
Fix: Create `docs/02-addressing-plan.md` with the IP and ASN allocation worksheets.

[SEVERITY: High]
[TYPE: Broken Reference]
File: `labs/pacixp.clabs.yml`:27, 40
Finding: The lab topology references `.conf` files for Route Server and Member configs, but the repository uses the `.cfg` extension.
Evidence: Node `rs1` binds `configs/rs1.conf` while the file on disk is `labs/configs/rs1.cfg`.
Impact: The lab environment fails to deploy as Containerlab cannot find the bind-mounted configuration files.
Fix: Update `labs/pacixp.clabs.yml` to use `.cfg` extensions for all bind mounts.

[SEVERITY: High]
[TYPE: Incomplete]
File: `labs/pacixp.clabs.yml`:47-73
Finding: The lab topology defines 5 member nodes, but only `member1.cfg` exists in the configuration directory.
Evidence: `labs/configs/peers/` contains only `member1.cfg`; `member2` through `member5` are missing.
Impact: Deployment of the lab environment will fail for nodes `member2` through `member5` due to missing mount sources.
Fix: Generate the missing `member2.cfg` through `member5.cfg` files.

[SEVERITY: High]
[TYPE: Contradiction]
File: `labs/configs/sw1.cfg`:1, `labs/configs/rs1.cfg`:1
Finding: Lab configurations for switches and route servers are IPv4-only, contradicting the "Dual-Stack by Design" mandate.
Evidence: `labs/configs/sw1.cfg` lacks all IPv6 interface and BGP configuration required by DP-10.
Impact: The "Production Ready" claim is invalidated as the lab cannot verify IPv6 peering parity.
Fix: Add IPv6 addressing and OSPFv3/BGP-EVPN configuration to all lab configuration files.

[SEVERITY: High]
[TYPE: Incomplete]
File: `configs/switches/arista_sw1.md`:45, `configs/switches/juniper_sw1.md`:62
Finding: Reference ACLs use generic permit-all statements instead of the IP-specific anti-spoofing filters mandated by the design.
Evidence: `arista_sw1.md` defines `permit ip any any` in `ACL-IXP-PEERING-V4` despite HLD Section 5.2 requiring IP-specific filters.
Impact: Members can spoof IP addresses of other peers, violating MANRS Action 2.
Fix: Update reference templates to include placeholders for member-specific source IP filtering.

[SEVERITY: Medium]
[TYPE: Security]
File: `templates/ixp-manager-docker-compose.yml`:48, `docs/05-ixp-manager.md`:15
Finding: The IXP Manager deployment template exposes port 443 without SSL volumes and defaults to HTTP.
Evidence: `nginx` service ports include 443 but no `certs` volume is mounted; `APP_URL` uses `http://`.
Impact: Management credentials and session data are transmitted in plaintext by default.
Fix: Add SSL volume mounts to the Docker Compose template and update documentation to use HTTPS.

[SEVERITY: Medium]
[TYPE: Security]
File: `templates/ixp-manager-docker-compose.yml`:31, 64
Finding: Docker images for the core IXP Manager services are not version-pinned.
Evidence: Services `ixp-manager` and `cron` use `image: inex/ixp-manager:latest`.
Impact: Future deployments may pull breaking changes, leading to non-deterministic and unstable production environments.
Fix: Pin images to a specific stable release (e.g., `v6.3.0`).

[SEVERITY: Medium]
[TYPE: Contradiction]
File: `configs/switches/juniper_sw1.md`:138 vs `docs/00-design-principles.md`:218
Finding: The Juniper member port configuration sets a jumbo MTU, contradicting the design principle for 1500-byte standard ports.
Evidence: `juniper_sw1.md` sets `mtu 9216` on `xe-0/0/0` while DP-11 states "member devices use standard 1500-byte MTU."
Impact: Inconsistent MTU enforcement may lead to intermittent path MTU discovery issues for members.
Fix: Remove the explicit jumbo MTU from the Juniper member port reference configuration.

[SEVERITY: Medium]
[TYPE: Broken Reference]
File: `strategy/automation.md`:48
Finding: The automation strategy refers to a critical Route Server configuration script that is missing from the repository.
Evidence: `automation.md` references `ixp-manager-bird-api` as the mechanism for BIRD config generation, but no such file exists.
Impact: The stated automation workflow for the "Mission Critical" control plane is non-functional as-written.
Fix: Add the `ixp-manager-bird-api` script or provide specific installation/download instructions.

[SEVERITY: Low]
[TYPE: Security]
File: `configs/switches/arista_sw1.md`:151
Finding: The Arista reference configuration uses a predictable SNMP community string without a security warning.
Evidence: `snmp-server community PACIXP-public ro` is used without an inline warning to modify it.
Impact: High risk of unauthorized information disclosure if the template is deployed as-is.
Fix: Add a prominent warning comment immediately preceding the SNMP community configuration.

[SEVERITY: Low]
[TYPE: Contradiction]
File: `docs/01-high-level-design.md`:135 vs `labs/configs/sw1.cfg`:46
Finding: The infrastructure addressing in the lab configuration deviates from the master addressing plan in the HLD.
Evidence: HLD specifies Loopback0 as `.11` for SW1, while `sw1.cfg` uses `.1`.
Impact: Divergence between lab and documentation increases the risk of mental model errors during production deployment.
Fix: Synchronize the lab configuration IP addresses with the HLD addressing plan.

[SEVERITY: Low]
[TYPE: Incomplete]
File: `configs/switches/arista_sw1.md`:101
Finding: The Arista member port configuration does not explicitly disable Proxy-ARP.
Evidence: Interface `Ethernet3` lacks the `no ip proxy-arp` command, which is enabled by default in EOS.
Impact: Members may inadvertently respond to ARP requests for other peers, causing traffic disruption on the Peering LAN.
Fix: Add `no ip proxy-arp` to the member-facing interface template in `arista_sw1.md`.

## Prioritized Action List

1.  `strategy/virtualization.md`: Change RPKI failure mode to "Fail Closed" to align with DP-5.
2.  `docs/02-addressing-plan.md`: Create the missing file with IP and ASN allocation tables.
3.  `labs/pacixp.clabs.yml`: Update all node definitions to reference `.cfg` instead of `.conf`.
4.  `labs/pacixp.clabs.yml`: Add IPv6 address assignment to `rs1` node `exec` list.
5.  `labs/configs/peers/`: Generate `member2.cfg` through `member5.cfg` files.
6.  `templates/ixp-manager-docker-compose.yml`: Pin `inex/ixp-manager` image to a specific version.
7.  `templates/ixp-manager-docker-compose.yml`: Add SSL volume mounts and Nginx SSL configuration.
8.  `docs/05-ixp-manager.md`: Update `APP_URL` and GUI access instructions to use `https://`.
9.  `labs/configs/sw1.cfg`: Add IPv6 addressing and OSPFv3/EVPN-BGP configuration for dual-stack parity.
10. `labs/configs/rs1.cfg`: Add IPv6 BGP session blocks for all 5 members.
11. `configs/switches/arista_sw1.md`: Update `ACL-IXP-PEERING-V4` to include member-specific IP permit placeholders.
12. `configs/switches/arista_sw1.md`: Add `no ip proxy-arp` to the member port template.
13. `configs/switches/arista_sw1.md`: Add a warning comment regarding the default SNMP community string.
14. `configs/switches/juniper_sw1.md`: Remove `mtu 9216` from the member port interface to align with DP-11.
15. `strategy/automation.md`: Provide the source or clear instructions for `ixp-manager-bird-api`.
16. `labs/configs/sw1.cfg`: Update Loopback0 IP to `.11` to match the HLD master plan.
