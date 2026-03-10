#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

optimize_jpeg() {
  local file="$1"
  local max_size="$2"
  local quality="$3"
  local tmp_file

  tmp_file="$(mktemp "${TMPDIR:-/tmp}/imgopt.XXXXXX.jpg")"
  sips --resampleHeightWidthMax "$max_size" \
    --setProperty format jpeg \
    --setProperty formatOptions "$quality" \
    "$file" \
    --out "$tmp_file" >/dev/null
  mv "$tmp_file" "$file"
}

find "$ROOT_DIR/assets/gallery" -type f -name '*.jpg' | while read -r file; do
  optimize_jpeg "$file" 1600 68
done

for file in \
  "$ROOT_DIR/assets/hero-construction.jpg" \
  "$ROOT_DIR/assets/obra-civil.jpg" \
  "$ROOT_DIR/assets/obra-exterior.jpg" \
  "$ROOT_DIR/assets/obra-interior.jpg" \
  "$ROOT_DIR/assets/obra-moderna.jpg" \
  "$ROOT_DIR/assets/obra-nueva.jpg" \
  "$ROOT_DIR/assets/obra-rustica.jpg" \
  "$ROOT_DIR/assets/equipo.jpg"; do
  optimize_jpeg "$file" 1800 72
done

echo "Image optimization complete."
