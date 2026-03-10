#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HOSTINGER_HOST="${HOSTINGER_HOST:-82.25.113.156}"
HOSTINGER_PORT="${HOSTINGER_PORT:-65002}"
HOSTINGER_USER="${HOSTINGER_USER:-u837856432}"
HOSTINGER_KEY="${HOSTINGER_KEY:-$HOME/.ssh/codex_hostinger_business_ed25519}"
DOMAIN="${1:-construccionesfgarcia.es}"
LOCAL_DIR="${2:-$ROOT_DIR}"
REMOTE_DIR="domains/${DOMAIN}/public_html"

if [[ "${3:-}" == "--dry-run" ]] || [[ "${DRY_RUN:-0}" == "1" ]]; then
  RSYNC_DRY_RUN="--dry-run"
else
  RSYNC_DRY_RUN=""
fi

if [[ ! -d "$LOCAL_DIR" ]]; then
  echo "Local directory not found: $LOCAL_DIR" >&2
  exit 1
fi

ssh -i "$HOSTINGER_KEY" -p "$HOSTINGER_PORT" -o BatchMode=yes -o ConnectTimeout=15 \
  "${HOSTINGER_USER}@${HOSTINGER_HOST}" "test -d '$REMOTE_DIR'"

rsync -avz --delete $RSYNC_DRY_RUN \
  --exclude ".git/" \
  --exclude ".DS_Store" \
  --exclude "site-download/" \
  --exclude "scripts/" \
  --exclude "README.md" \
  -e "ssh -i $HOSTINGER_KEY -p $HOSTINGER_PORT -o BatchMode=yes" \
  "$LOCAL_DIR"/ "${HOSTINGER_USER}@${HOSTINGER_HOST}:$REMOTE_DIR/"

echo "Deploy finished for ${DOMAIN}"
