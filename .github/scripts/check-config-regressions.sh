#!/usr/bin/env bash
# Flags known-bad patterns that correspond to open TODO items.
# Each check documents WHY it exists so the failure is self-explanatory.
set -euo pipefail

ERRORS=0

pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1"; ERRORS=$((ERRORS + 1)); }

# ------------------------------------------------------------------
# 1. No :latest image tags in docker-compose
#    TODO: "No Cron Image Version Pinning" (Medium)
#    :latest tags make deployments non-reproducible and hide upgrades.
# ------------------------------------------------------------------
if grep -q ':latest' templates/ixp-manager-docker-compose.yml; then
  fail "':latest' image tag found in templates/ixp-manager-docker-compose.yml — pin to a specific version"
else
  pass "No :latest image tags in compose"
fi

# ------------------------------------------------------------------
# 2. RPKI protocol block must not be commented out in rs1.cfg
#    TODO: "RPKI Block Commented Out in rs1.cfg" (Critical)
#    A commented-out RPKI block means RPKI is fully disabled in the lab.
# ------------------------------------------------------------------
if grep -qE '^\s*#\s*protocol\s+rpki' labs/configs/rs1.cfg; then
  fail "RPKI protocol block is commented out in labs/configs/rs1.cfg — uncomment to enable RPKI"
else
  pass "RPKI protocol block not commented out in rs1.cfg"
fi

# ------------------------------------------------------------------
# 3. APP_URL must use HTTPS in compose / env templates
#    TODO: "HTTPS/TLS Not Configured for IXP Manager" (Critical)
#    HTTP-only APP_URL means IXP Manager will generate insecure links.
# ------------------------------------------------------------------
if grep -rq 'APP_URL=http://' templates/; then
  fail "'APP_URL=http://' found in templates/ — IXP Manager must be served over HTTPS"
else
  pass "No insecure APP_URL in templates"
fi

# ------------------------------------------------------------------
# 4. Runbooks must not contain RFC1918 addresses
#    TODO: "Runbook Uses RFC1918 Addresses (Violates DP-12)" (Medium)
#    DP-12 forbids RFC1918 in all documentation; use RFC5737 (203.0.113.x) instead.
# ------------------------------------------------------------------
if grep -rE '(10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3})' runbooks/; then
  fail "RFC1918 address found in runbooks/ — replace with RFC5737 documentation ranges per DP-12"
else
  pass "No RFC1918 addresses in runbooks"
fi

# ------------------------------------------------------------------
# 5. Juniper storm-control must not be silently disabled
#    TODO: "Juniper Storm-Control Functionally Disabled" (High)
#    no-broadcast-suppression inside a bandwidth-level stanza disables
#    broadcast suppression, making the storm-control profile a no-op.
# ------------------------------------------------------------------
if grep -q 'no-broadcast-suppression' configs/switches/juniper_sw1.md; then
  fail "'no-broadcast-suppression' found in configs/switches/juniper_sw1.md — storm-control is silently disabled"
else
  pass "Juniper storm-control not silently disabled"
fi

# ------------------------------------------------------------------
# 6. DHCPv6 client (UDP 546) must be blocked in the Arista IPv6 ACL
#    Fixed in this repo; this check prevents regression.
#    Both client and server must be denied — DHCP of any form is
#    prohibited on the IXP fabric.
# ------------------------------------------------------------------
if ! grep -q 'dhcpv6-client' configs/switches/arista_sw1.md; then
  fail "DHCPv6 client (UDP 546) not blocked in configs/switches/arista_sw1.md — add 'deny udp any any eq dhcpv6-client'"
else
  pass "DHCPv6 client blocked in Arista IPv6 ACL"
fi

# ------------------------------------------------------------------
# 7. Juniper member port must not set jumbo MTU
#    TODO: "Juniper Member Port Sets Jumbo MTU" (Low)
#    DP-11 specifies 1500-byte MTU for member devices; mtu 9216 can
#    cause path MTU discovery issues for members.
#    Infrastructure (INFRA:) interfaces legitimately use mtu 9216.
#    Check only within 8 lines after a MEMBER: description line.
# ------------------------------------------------------------------
if grep -A8 'MEMBER:' configs/switches/juniper_sw1.md | grep -q 'mtu 9216'; then
  fail "'mtu 9216' found within a MEMBER port block in configs/switches/juniper_sw1.md — remove per DP-11"
else
  pass "No jumbo MTU on Juniper member port"
fi

# ------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------
echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "FAIL: ${ERRORS} regression check(s) failed."
  exit 1
fi
echo "PASS: All config regression checks passed."
