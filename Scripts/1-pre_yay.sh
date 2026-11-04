#!/usr/bin/env bash
set -euo pipefail

# Pre-Yay Official Repositories & Base Build Tools Installation Script
# Handles core system utilities, compilation dependencies, media support, and archives.

echo "[*] Updating package databases..."
sudo pacman -Syu --noconfirm

echo "[*] Installing pre-yay applications, build tools, codecs, and format handlers..."
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    curl \
    wget \
    fastfetch \
    btop \
    vlc \
    gst-plugins-good \
    gst-plugins-bad \
    gst-plugins-ugly \
    gst-libav \
    ark \
    unrar \
    p7zip \
    zip \
    unzip \
    tar \
    lzop \
    cpio \
    squashfs-tools \
    zram-generator

echo "[+] Pre-yay applications and base dependencies installed successfully."
