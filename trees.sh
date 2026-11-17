#!/bin/bash
# Clone the device trees, kernel sources and extras for Sapphire.
# Run from the ROM source root.
set -e

ORG=https://github.com/The-Angel-Place-Sapphire

clone() { # <repo> <branch> <path>
    echo "-> $3 ($1 @ $2)"
    rm -rf "$3"
    git clone --depth 1 -b "$2" "$ORG/$1.git" "$3"
}

echo "Cloning Device Trees for Sapphire..."

# The kernel is built from source; the prebuilt kernel tree is no longer used
rm -rf device/xiaomi/sapphire-kernel

# Kernel (built from source)
clone kernel_xiaomi_sapphire              lineage-23.2 kernel/xiaomi/sapphire
clone kernel_xiaomi_sapphire-devicetrees  lineage-23.2 kernel/xiaomi/sapphire-devicetrees
clone kernel_xiaomi_sapphire-modules      lineage-23.2 kernel/xiaomi/sapphire-modules

# Device trees
clone device_xiaomi_sepolicy              16           device/xiaomi/sepolicy
clone device_xiaomi_sapphire              lineage-23.2 device/xiaomi/sapphire
clone vendor_xiaomi_sapphire              lineage-23.2 vendor/xiaomi/sapphire
clone android_hardware_xiaomi             lineage-23.2 hardware/xiaomi

# Used by device_xiaomi_sapphire
clone hardware_dolby                      16           hardware/dolby
clone packages_apps_XiaomiParts           16.2         packages/apps/XiaomiParts
clone device_xiaomi_miuicamera-sapphire   lineage-24.0 device/xiaomi/miuicamera-sapphire
clone vendor_xiaomi_miuicamera-sapphire   lineage-24.0 vendor/xiaomi/miuicamera-sapphire

echo "============================"
echo "Device Trees cloned successfully"
echo "============================"
