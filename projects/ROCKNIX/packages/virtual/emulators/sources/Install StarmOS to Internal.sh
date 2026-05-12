#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 StarmOS

set -euo pipefail

source /etc/profile

STARMOS_STATE_DIR="/storage/.config/starmos"
REQUEST_MARKER="${STARMOS_STATE_DIR}/internal-install-requested"

is_rp6() {
  case "${QUIRK_DEVICE:-}" in
    "Retroid Pocket 6"|"Retroid Pocket 6 TOP-DPAD") return 0 ;;
    *) return 1 ;;
  esac
}

if ! is_rp6; then
  echo "This tool is only supported on Retroid Pocket 6 (SM8550)." >&2
  echo "Detected: QUIRK_DEVICE='${QUIRK_DEVICE:-unknown}'" >&2
  sleep 5
  exit 1
fi

echo ""
echo "StarmOS (Alpha) - Install to Internal Storage (RP6)"
echo "=================================================="
echo ""
echo "WARNING:"
echo "- This will erase Android / internal userdata on the device."
echo "- Do not proceed unless you have backed up anything important."
echo "- When asked whether to copy existing /storage, answer: y"
echo "  (this preserves the internal-install marker needed for automatic Steam provisioning)."
echo ""
echo "Type this exact phrase to continue:"
echo "  INSTALL STARMOS TO INTERNAL"
echo ""
read -r -p "> " phrase
if [ "${phrase}" != "INSTALL STARMOS TO INTERNAL" ]; then
  echo "Aborted."
  sleep 2
  exit 1
fi

mkdir -p "${STARMOS_STATE_DIR}"
date -Is 2>/dev/null >"${REQUEST_MARKER}" || : >"${REQUEST_MARKER}"

echo ""
echo "Internal install requested marker written:"
echo "  ${REQUEST_MARKER}"
echo ""
echo "Starting installtointernal..."
echo ""

if command -v starmos-enable-gamemode >/dev/null 2>&1; then
  starmos-enable-gamemode >/dev/null 2>&1 || true
fi

if ! command -v installtointernal >/dev/null 2>&1; then
  echo "ERROR: installtointernal not found in this image." >&2
  sleep 5
  exit 1
fi

installtointernal

echo ""
echo "Install complete."
echo "Reboot, remove the SD card, then boot from internal storage."
sleep 5

