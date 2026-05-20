#!/usr/bin/env python3
"""
Sanity-checks the containerlab topology file:
  1. Every bind-mount source path must exist on disk.
  2. labs/README.md deploy command must reference the correct topology filename.

Failing checks correspond directly to open TODO items so that CI stays red
until the underlying problem is fixed.
"""
import sys
import os
import yaml

ERRORS = 0
TOPO_FILE = "labs/pacixp.clabs.yml"
README_FILE = "labs/README.md"


def fail(msg: str) -> None:
    global ERRORS
    print(f"FAIL: {msg}")
    ERRORS += 1


def passcheck(msg: str) -> None:
    print(f"PASS: {msg}")


# ------------------------------------------------------------------
# Check 1: bind-mount source files exist
# TODO: "Incomplete Lab Topology" (Critical) — .conf vs .cfg mismatch
# ------------------------------------------------------------------
topo_dir = os.path.dirname(TOPO_FILE)

with open(TOPO_FILE) as fh:
    topo = yaml.safe_load(fh)

nodes = topo.get("topology", {}).get("nodes", {}) or {}

for node_name, node_cfg in nodes.items():
    if not node_cfg:
        continue
    for bind in node_cfg.get("binds", []) or []:
        # Bind format: "source:destination[:options]" or bare "source"
        src = bind.split(":")[0]
        full_src = os.path.join(topo_dir, src)
        if not os.path.exists(full_src):
            fail(
                f"node '{node_name}': bind-mount source missing: {src} "
                f"(expected at {full_src})"
            )
        else:
            passcheck(f"node '{node_name}': bind-mount source exists: {src}")

# ------------------------------------------------------------------
# Check 2: README deploy command uses the correct topology filename
# TODO: "labs/README.md Deploy Command Broken" (Critical)
# ------------------------------------------------------------------
topo_basename = os.path.basename(TOPO_FILE)

with open(README_FILE) as fh:
    readme_content = fh.read()

if topo_basename not in readme_content:
    fail(
        f"labs/README.md deploy command does not reference '{topo_basename}' "
        f"— update the 'containerlab deploy' command"
    )
else:
    passcheck(f"labs/README.md references correct topology filename '{topo_basename}'")

# ------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------
print()
if ERRORS > 0:
    print(f"FAIL: {ERRORS} lab topology check(s) failed.")
    sys.exit(1)

print("PASS: All lab topology checks passed.")
