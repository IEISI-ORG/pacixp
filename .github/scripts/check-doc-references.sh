#!/usr/bin/env bash
# Checks that markdown inline links pointing to local files actually exist.
# External links (http/https/mailto) and same-page anchors (#) are skipped.
set -euo pipefail

ERRORS=0

# Find all owned markdown files; exclude third-party documents and review outputs
while IFS= read -r mdfile; do
  dir=$(dirname "$mdfile")

  # Extract the URL part of every inline link: [text](url)
  # grep -oE is POSIX-portable on GNU grep (Ubuntu runners)
  while IFS= read -r raw_link; do
    # Strip optional title: path "title" -> path
    link="${raw_link%% *}"
    link="${link%\"*}"

    # Skip external and anchor-only links
    case "$link" in
      http://*|https://*|mailto:*|ftp://*|\#*) continue ;;
    esac

    # Strip in-page anchor suffix so we validate the file, not the anchor
    target="${link%%\#*}"
    [ -z "$target" ] && continue

    # Resolve relative to the containing markdown file's directory
    if [[ "$target" == /* ]]; then
      fullpath=".${target}"
    else
      fullpath="${dir}/${target}"
    fi

    if [ ! -e "$fullpath" ]; then
      echo "FAIL: broken reference in ${mdfile} -> ${target}"
      ERRORS=$((ERRORS + 1))
    fi
  done < <(
    grep -oE '\[([^]]*)\]\(([^)]+)\)' "$mdfile" \
      | sed 's/.*](\(.*\))/\1/' \
      || true
  )
done < <(
  find . -name '*.md' \
    -not -path './documents/*' \
    -not -path './reviews/*' \
    -not -path './.git/*'
)

echo ""
if [ "$ERRORS" -gt 0 ]; then
  echo "FAIL: ${ERRORS} broken internal reference(s) found."
  exit 1
fi
echo "PASS: All internal file references are valid."
