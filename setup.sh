#!/bin/sh
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"

mkdir -p "$DEST/hooks"

cp "$REPO_DIR/statusline-command.sh" "$DEST/statusline-command.sh"
chmod +x "$DEST/statusline-command.sh"

cp "$REPO_DIR/hooks/block-env-access.js" "$DEST/hooks/block-env-access.js"

sed "s|/Users/YOUR_USERNAME|$HOME|g" "$REPO_DIR/settings.json" > "$DEST/settings.json"

echo "Done. Files copied to $DEST"
