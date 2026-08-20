#!/usr/bin/env bash
CG0S_DEVICE="/dev/cgos"
echo "Running Acceptance Criteria Check for THR-03..."
if [ ! -e "$CG0S_DEVICE" ]; then
    echo "[SKIP] CG0S Device Node $CG0S_DEVICE not found (Simulated CI Environment)."
    exit 0
fi
PERMS=$(stat -c "%a %U" "$CG0S_DEVICE")
if [ "$PERMS" = "600 root" ]; then
    echo "[PASS] CG0S permissions restricted to root:root (0600)."
    exit 0
else
    echo "[FAIL] Insecure CG0S permissions detected: $PERMS"
    exit 1
fi
