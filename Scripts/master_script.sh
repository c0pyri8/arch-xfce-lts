#!/usr/bin/env bash
set -euo pipefail

# Lightweight Master Orchestration Script
# Pipes verbose logs to files to prevent terminal buffer flooding and crashes.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/logs"
mkdir -p "$LOG_DIR"

SCRIPTS=(
    "1-pre_yay.sh"
    "2-Customization.sh"
    "3-swap-space.sh"
    "4-yay_&_Post_yay.sh"
    "5-applications_checks.sh"
)

echo "=================================================="
echo "    Arch Linux XFCE Setup (Safe Log Mode)       "
echo "=================================================="

for script in "${SCRIPTS[@]}"; do
    script_path="$SCRIPT_DIR/$script"
    log_file="$LOG_DIR/${script%.sh}.log"

    if [ ! -f "$script_path" ]; then
        echo "[!] Error: Required script $script not found!"
        exit 1
    }

    chmod +x "$script_path"
    echo -n "-> Executing $script... "

    # Run script and pipe output to log file to keep the terminal safe from flooding
    if "$script_path" > "$log_file" 2>&1; then
        echo "SUCCESS"
    else
        echo "FAILED!"
        echo "--------------------------------------------------"
        echo "Last 15 lines of error log ($log_file):"
        tail -n 15 "$log_file"
        echo "--------------------------------------------------"
        exit 1
    fi
done

echo ""
echo "=================================================="
echo "   All stages completed! Full logs saved in logs/"
echo "=================================================="
