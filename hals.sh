#!/bin/bash
# Clone the SM6225 HALs used by Sapphire.
# Run from the ROM source root.
set -e

ORG=https://github.com/The-Angel-Place-Sapphire

clone() { # <repo> <branch> <path>
    echo "-> $3 ($1 @ $2)"
    rm -rf "$3"
    git clone --depth 1 -b "$2" "$ORG/$1.git" "$3"
}

echo "Cloning HALs for SM6225..."

# Replaces the LineageOS one; the ROM manifest's linkfiles keep pointing here
clone android_hardware_qcom-caf_common        lineage-23.2            hardware/qcom-caf/common

clone vendor_qcom_opensource_agm              lineage-23.2-caf-sm6225 hardware/qcom-caf/sm6225/audio/agm
clone vendor_qcom_opensource_arpal-lx         lineage-23.2-caf-sm6225 hardware/qcom-caf/sm6225/audio/pal
clone vendor_qcom_opensource_data-ipa-cfg-mgr lineage-23.2-caf-sm6225 hardware/qcom-caf/sm6225/data-ipa-cfg-mgr
clone vendor_qcom_opensource_dataipa          lineage-23.2-caf-sm6225 hardware/qcom-caf/sm6225/dataipa
clone hardware_qcom_display                   lineage-22.0-caf-sm6225 hardware/qcom-caf/sm6225/display
clone hardware_qcom_media                     lineage-23.2-caf-sm6225 hardware/qcom-caf/sm6225/media
clone hardware_qcom_audio                     lineage-22.0-caf-sm6225 hardware/qcom-caf/sm6225/audio/primary-hal
clone device_qcom_sepolicy_vndr               lineage-23.2-caf-sm6225 device/qcom/sepolicy_vndr/sm6225

echo "============================"
echo "HALs cloned successfully"
echo "============================"
