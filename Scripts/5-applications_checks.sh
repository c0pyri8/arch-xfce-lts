#!/usr/bin/env bash
set -uo pipefail

# Ultra-Lightweight Application Health & Installation Verification
# Checks all 18 targets sequentially without resource spikes.

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

APPS=(
    "ark"
    "base-devel"
    "curl"
    "fakeroot"
    "fastfetch"
    "git"
    "yay"
    "zram-generator"
    "brave-origin"
    "btop"
    "caido"
    "kio-admin"
    "google-chrome"
    "notepadqq"
    "signal-desktop"
    "spotify"
    "steam"
    "vlc"
)

echo "==> Verifying application states..."

for app in "${APPS[@]}"; do
    pkg="$app"
    if [ "$app" == "chrome" ]; then pkg="google-chrome"
    elif [ "$app" == "Signal" ]; then pkg="signal-desktop"
    elif [ "$app" == "Spotify" ]; then pkg="spotify"
    elif [[ "$app" == *"VLC"* ]]; then pkg="vlc"
    fi

    if [ "$app" == "brave-origin" ]; then
        if pacman -Qi brave-origin &> /dev/null || pacman -Qi brave-origin-bin &> /dev/null || command -v brave &> /dev/null; then
            echo -e "[ ${GREEN}OK${NC} ] $app"
        else
            echo -e "[ ${RED}MISSING${NC} ] $app"
        fi
        continue
    fi

    if pacman -Qi "$pkg" &> /dev/null || command -v "$pkg" &> /dev/null; then
        echo -e "[ ${GREEN}OK${NC} ] $app"
    else
        echo -e "[ ${RED}MISSING${NC} ] $app"
    fi
done
