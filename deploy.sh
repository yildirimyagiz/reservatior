#!/bin/bash
set -e

BUILD_DIR="/root/reservatior/client/dist"
DEPLOY_DIR="/var/www/reservatior.com"

echo "=== Deploying client build ==="

# Copy index.html
cp "$BUILD_DIR/index.html" "$DEPLOY_DIR/"

# Copy all assets (overwrite existing)
cp -r "$BUILD_DIR/assets/"* "$DEPLOY_DIR/assets/"

# Remove files that exist in deploy but NOT in the fresh build (truly stale)
for f in "$DEPLOY_DIR/assets/"*.js; do
  base=$(basename "$f")
  if [ ! -f "$BUILD_DIR/assets/$base" ]; then
    rm "$f"
    echo "  Removed stale: $base"
  fi
done

echo "=== Deploy complete ==="
echo "Assets: $(ls "$DEPLOY_DIR/assets/"*.js | wc -l) JS files"
