#!/bin/bash
# Build script for Ontime Controller 3.0
# Concatenates split source files into a single .qplug in the order
# defined by the #include directives in plugin.lua

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$SCRIPT_DIR/../Ontime_Controller_3.0.qplug"

FILES=(
  "info.lua"
  "properties.lua"
  "controls.lua"
  "layout.lua"
  "runtime.lua"
)

> "$OUTPUT"

for f in "${FILES[@]}"; do
  if [ ! -f "$SCRIPT_DIR/$f" ]; then
    echo "ERROR: $f not found" >&2
    exit 1
  fi
  cat "$SCRIPT_DIR/$f" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
done

echo "Built: $OUTPUT"
