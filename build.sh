#!/bin/bash

# Usage: ./build.sh -v <version> [-a <app name>] [-o <dmg path>]
# Examples:
#   ./build.sh -v 1.0.0                                          # Production: Speakaway.app
#   ./build.sh -v 1.0.0 -a "Speakaway UAT" -o Releases/Speakaway-UAT-1.0.0.dmg

VERSION=""
APP_NAME="Speakaway"
DMG_OUT=""

while getopts "v:a:o:" opt; do
  case $opt in
    v) VERSION="$OPTARG" ;;
    a) APP_NAME="$OPTARG" ;;
    o) DMG_OUT="$OPTARG" ;;
    *) echo "Usage: $0 -v <version> [-a <app name>] [-o <dmg path>]"; exit 1 ;;
  esac
done

if [ -z "$VERSION" ]; then
  echo "❌ Version is required. Usage: $0 -v <version> [-a <app name>] [-o <dmg path>]"
  exit 1
fi

DMG_NAME="${DMG_OUT:-Releases/Speakaway-${VERSION}.dmg}"

echo "🔨 Building $DMG_NAME from ${APP_NAME}.app ..."

create-dmg \
  --volname "$APP_NAME" \
  --volicon "${APP_NAME}.app/Contents/Resources/AppIcon.icns" \
  --background "dmg-background.png" \
  --window-pos 200 120 \
  --window-size 660 400 \
  --icon-size 120 \
  --icon "${APP_NAME}.app" 200 240 \
  --hide-extension "${APP_NAME}.app" \
  --app-drop-link 460 240 \
  "$DMG_NAME" \
  "${APP_NAME}.app"

if [ $? -eq 0 ]; then
  echo "✅ Done! Created: $DMG_NAME"
else
  echo "❌ Failed to create DMG."
  exit 1
fi
