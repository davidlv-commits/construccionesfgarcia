#!/usr/bin/env bash

set -euo pipefail

HOSTINGER_HOST="${HOSTINGER_HOST:-82.25.113.156}"
HOSTINGER_PORT="${HOSTINGER_PORT:-65002}"
HOSTINGER_USER="${HOSTINGER_USER:-u837856432}"
HOSTINGER_KEY="${HOSTINGER_KEY:-$HOME/.ssh/codex_hostinger_business_ed25519}"

ssh -i "$HOSTINGER_KEY" -p "$HOSTINGER_PORT" -o BatchMode=yes -o ConnectTimeout=15 \
  "${HOSTINGER_USER}@${HOSTINGER_HOST}" \
  'pwd && echo "---" && find domains -maxdepth 2 -type d | sort'
