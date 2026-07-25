#!/bin/bash
# HALs for SM6225 on StatiX bp4a
# Run from your ROM source root.

echo "Cloning HALs for SM6225..."

ORG="https://github.com/The-Angel-Place-Sapphire"

rm -rf hardware/qcom-caf/common
git clone --depth 1 -b lineage-23.2 $ORG/android_hardware_qcom-caf_common.git hardware/qcom-caf/common

rm -rf hardware/qcom-caf/sm6225/audio/agm
git clone --depth 1 -b lineage-22.2-caf-sm6225 $ORG/vendor_qcom_opensource_agm.git hardware/qcom-caf/sm6225/audio/agm

rm -rf hardware/qcom-caf/sm6225/audio/pal
git clone --depth 1 -b lineage-22.0-caf-sm6225 $ORG/vendor_qcom_opensource_arpal-lx.git hardware/qcom-caf/sm6225/audio/pal

rm -rf hardware/qcom-caf/sm6225/audio/primary-hal
git clone --depth 1 -b lineage-22.0-caf-sm6225 $ORG/hardware_qcom_audio.git hardware/qcom-caf/sm6225/audio/primary-hal

rm -rf hardware/qcom-caf/sm6225/data-ipa-cfg-mgr
git clone --depth 1 -b lineage-22.0-caf-sm6225 $ORG/vendor_qcom_opensource_data-ipa-cfg-mgr.git hardware/qcom-caf/sm6225/data-ipa-cfg-mgr

rm -rf hardware/qcom-caf/sm6225/dataipa
git clone --depth 1 -b lineage-22.0-caf-sm6225 $ORG/vendor_qcom_opensource_dataipa.git hardware/qcom-caf/sm6225/dataipa

rm -rf hardware/qcom-caf/sm6225/display
git clone --depth 1 -b lineage-22.0-caf-sm6225 $ORG/hardware_qcom_display.git hardware/qcom-caf/sm6225/display

rm -rf hardware/qcom-caf/sm6225/media
git clone --depth 1 -b lineage-22.0-caf-sm6225 $ORG/hardware_qcom_media.git hardware/qcom-caf/sm6225/media

rm -rf device/qcom/sepolicy_vndr/sm6225
git clone --depth 1 -b lineage-23.0-caf-sm6225 $ORG/device_qcom_sepolicy_vndr.git device/qcom/sepolicy_vndr/sm6225

echo "============================"
echo "HALs cloned successfully"
echo "============================"
