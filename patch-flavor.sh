#!/bin/bash
# Patch everforest-medium flavor for yazi 25.12+ compatibility
# Works on macOS and Linux

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAVOR_FILE="$SCRIPT_DIR/flavor.toml"

[[ -f "$FLAVOR_FILE" ]] || { echo "flavor.toml not found"; exit 1; }

# Patch permissions_* -> perm_*
if grep -q "permissions_s" "$FLAVOR_FILE" 2>/dev/null; then
    echo "Patching permissions fields..."

    if [[ "$(uname)" == "Darwin" ]]; then
        sed -i '' \
            -e 's/permissions_s/perm_sep/g' \
            -e 's/permissions_t/perm_type/g' \
            -e 's/permissions_r/perm_read/g' \
            -e 's/permissions_w/perm_write/g' \
            -e 's/permissions_x/perm_exec/g' \
            "$FLAVOR_FILE"
    else
        sed -i \
            -e 's/permissions_s/perm_sep/g' \
            -e 's/permissions_t/perm_type/g' \
            -e 's/permissions_r/perm_read/g' \
            -e 's/permissions_w/perm_write/g' \
            -e 's/permissions_x/perm_exec/g' \
            "$FLAVOR_FILE"
    fi
    echo "Done!"
else
    echo "Already patched or no changes needed."
fi
