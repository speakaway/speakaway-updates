#!/bin/bash

# Usage: ./build.sh -v <version>
# Example: ./build.sh -v 1.0.0-beta1

VERSION=""

while getopts "v:" opt; do
  case $opt in
    v) VERSION="$OPTARG" ;;
    *) echo "Usage: $0 -v <version>"; exit 1 ;;
  esac
done

if [ -z "$VERSION" ]; then
  echo "❌ Version is required. Usage: $0 -v <version>"
  exit 1
fi

DMG_NAME="Releases/Speakaway-${VERSION}.dmg"

echo "🔨 Building $DMG_NAME ..."

create-dmg \
  --volname "Speakaway" \
  --volicon "Speakaway.app/Contents/Resources/AppIcon.icns" \
  --background "dmg-background.png" \
  --window-pos 200 120 \
  --window-size 660 400 \
  --icon-size 120 \
  --icon "Speakaway.app" 200 240 \
  --hide-extension "Speakaway.app" \
  --app-drop-link 460 240 \
  "$DMG_NAME" \
  "Speakaway.app"

if [ $? -eq 0 ]; then
  echo "✅ Done! Created: $DMG_NAME"
else
  echo "❌ Failed to create DMG."
  exit 1
fi