#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Deploying Custom Fonts system-wide..."
sudo mkdir -p /usr/share/fonts/custom
if [ -d "$SCRIPT_DIR/Fonts" ]; then
    sudo cp -r "$SCRIPT_DIR/Fonts/"* /usr/share/fonts/custom/
    sudo fc-cache -f -v
fi

echo "==> Deploying Custom Wallpapers system-wide..."
sudo mkdir -p /usr/share/wallpapers
if [ -d "$SCRIPT_DIR/Wallpapers" ]; then
    sudo cp -r "$SCRIPT_DIR/Wallpapers/"* /usr/share/wallpapers/
fi

echo "==> Executing System-Wide Chicago95 Installer..."
cd "$SCRIPT_DIR/C95"
sudo python3 installer.py

echo "==> Customization Deployment Complete."
