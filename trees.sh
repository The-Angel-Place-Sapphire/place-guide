#!/bin/bash
# Device trees for Sapphire (SM6225) on StatiX bp4a
# Run from your ROM source root.

echo "Cloning Device Trees for Sapphire (StatiX)..."

ORG="https://github.com/The-Angel-Place-Sapphire"
BR="statix-bp4a"

rm -rf device/xiaomi/sapphire
git clone --depth 1 -b $BR $ORG/device_xiaomi_sapphire.git device/xiaomi/sapphire

rm -rf device/xiaomi/sapphire-kernel
git clone --depth 1 -b $BR $ORG/device_xiaomi_sapphire-kernel.git device/xiaomi/sapphire-kernel

rm -rf device/xiaomi/sepolicy
git clone --depth 1 -b $BR $ORG/device_xiaomi_sepolicy.git device/xiaomi/sepolicy

rm -rf vendor/xiaomi/sapphire
git clone --depth 1 -b $BR $ORG/vendor_xiaomi_sapphire.git vendor/xiaomi/sapphire

rm -rf hardware/xiaomi
git clone --depth 1 -b $BR $ORG/android_hardware_xiaomi.git hardware/xiaomi

rm -rf hardware/dolby
git clone --depth 1 -b $BR $ORG/hardware_dolby.git hardware/dolby

rm -rf device/xiaomi/miuicamera-sapphire
git clone --depth 1 -b $BR $ORG/device_xiaomi_miuicamera-sapphire.git device/xiaomi/miuicamera-sapphire

rm -rf vendor/xiaomi/miuicamera-sapphire
git clone --depth 1 -b $BR $ORG/vendor_xiaomi_miuicamera-sapphire.git vendor/xiaomi/miuicamera-sapphire

echo "============================"
echo "Device Trees cloned successfully"
echo "============================"
