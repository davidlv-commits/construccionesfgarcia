#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GALLERY_DIR="$ROOT_DIR/assets/gallery"
OUTPUT_FILE="$GALLERY_DIR/manifest.js"

tmp_file="$(mktemp)"

{
  echo "window.GALLERY_MANIFEST = {"
  first_category=1

  find "$GALLERY_DIR" -mindepth 1 -maxdepth 1 -type d | sort | while read -r category_dir; do
    category="$(basename "$category_dir")"
    if [[ $first_category -eq 0 ]]; then
      echo ","
    fi
    first_category=0

    echo -n "  \"$category\": ["
    first_image=1
    find "$category_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort | while read -r image; do
      rel_path="${image#$ROOT_DIR/}"
      if [[ $first_image -eq 0 ]]; then
        echo -n ","
      fi
      first_image=0
      echo
      echo -n "    \"$rel_path\""
    done
    if [[ $first_image -eq 0 ]]; then
      echo
      echo -n "  ]"
    else
      echo -n "]"
    fi
  done
  echo
  echo "}"
} > "$tmp_file"

mv "$tmp_file" "$OUTPUT_FILE"
echo "Updated $OUTPUT_FILE"
