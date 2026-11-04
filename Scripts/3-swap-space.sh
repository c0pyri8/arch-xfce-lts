cat << 'EOF' > setup-swap.sh
#!/usr/bin/env bash
set -e

echo "==> Configuring ZRAM (2.5GiB, zstd compression)..."
sudo modprobe zram
echo zstd | sudo tee /sys/block/zram0/comp_algorithm
echo 2.5G | sudo tee /sys/block/zram0/disksize
sudo mkswap /dev/zram0
sudo swapon -p 100 /dev/zram0

echo "==> Provisioning 7.5GiB SSD Swapfile via dd..."
sudo dd if=/dev/zero of=/swapfile bs=1M count=7685 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon -p 50 /swapfile

echo "==> Configuring fstab persistence..."
if ! grep -q "/swapfile" /etc/fstab; then
    echo "/swapfile none swap defaults 0 0" | sudo tee -a /etc/fstab
fi

echo "==> Swap initialization complete. Active layout:"
swapon --show
EOF

chmod +x setup-swap.sh
sudo ./setup-swap.sh
