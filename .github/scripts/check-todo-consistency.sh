#!/usr/bin/env bash
# Verifies that TODO.md [x] checkboxes claiming a service was added to the
# compose file are truthful. Prevents "paper completion" where a checkbox
# is ticked without the underlying work being done.
set -euo pipefail

ERRORS=0
TODO="TODO.md"
COMPOSE="templates/ixp-manager-docker-compose.yml"

pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1"; ERRORS=$((ERRORS + 1)); }

# ------------------------------------------------------------------
# Helper: check_compose_claim <grep_pattern_in_todo> <service_keyword> <label>
#
# If TODO has a [x] line matching <grep_pattern_in_todo>, verify that
# <service_keyword> appears in the compose file.
# ------------------------------------------------------------------
check_compose_claim() {
  local todo_pattern="$1"
  local service_keyword="$2"
  local label="$3"

  if grep -qiE "^\s*-\s*\[x\].*${todo_pattern}" "$TODO"; then
    if ! grep -qi "$service_keyword" "$COMPOSE"; then
      fail "TODO marks '${label}' as added to compose, but '${service_keyword}' is absent from ${COMPOSE}"
    else
      pass "'${label}' present in compose (consistent with TODO [x])"
    fi
  fi
  # If the item is not checked [x], nothing to verify — skip silently.
}

# Match only lines that specifically claim a service was added to the compose file.
# "LibreNMS.*docker-compose" to avoid matching the [x] "Documented LibreNMS" line.
check_compose_claim "LibreNMS.*docker-compose|docker-compose.*LibreNMS" "librenms" "LibreNMS"
check_compose_claim "Oxidized.*docker-compose|docker-compose.*Oxidized" "oxidized" "Oxidized"
check_compose_claim "[Rr]outinator.*docker-compose|docker-compose.*[Rr]outinator" "routinator" "Routinator"

# ------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------
echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "FAIL: ${ERRORS} TODO consistency check(s) failed."
  exit 1
fi
echo "PASS: All TODO consistency checks passed."
