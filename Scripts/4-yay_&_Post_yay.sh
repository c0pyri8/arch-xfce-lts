#!/usr/bin/env bash
set -euo pipefail

# Optimized & Lightweight Yay + Post-Yay Applications Installer

echo "==> Step 1: Installing AUR build dependencies..."
sudo pacman -S --needed --noconfirm base-devel git fakeroot

echo "==> Step 2: Installing/Updating yay..."
if ! command -v yay &> /dev/null; then
    BUILD_DIR=$(mktemp -d)
    echo "Cloning yay into temporary directory ${BUILD_DIR}..."
    git clone --depth=1 https://aur.archlinux.org/yay.git "$BUILD_DIR/yay"
    cd "$BUILD_DIR/yay"
    MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm
    rm -rf "$BUILD_DIR"
else
    echo "yay is already installed."
fi

echo "==> Step 3: Installing Brave Browser..."
curl -fsS https://dl.brave.com/install.sh | FLAVOR=origin sh

echo "==> Step 4: Installing Steam (Official Repos)..."
sudo pacman -S --needed --noconfirm steam

echo "==> Step 5: Installing AUR applications sequentially..."
# Global makepkg optimization to build single-threaded and prevent RAM/CPU spikes
export MAKEFLAGS="-j1"

AUR_PKGS=(
    caido
    kio-admin
    google-chrome
    notepadqq
    signal-desktop
    spotify
)

for pkg in "${AUR_PKGS[@]}"; do
    echo "----------------------------------------"
    echo "Building & installing: $pkg"
    echo "----------------------------------------"
    yay -S --needed --noconfirm --cleanafter "$pkg" || {
        echo "[!] Failed to install $pkg, skipping to next package."
    }
done

echo "==> All installations complete!"
