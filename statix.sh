#!/bin/bash
# StatiX-side fixes for Sapphire (SM6225).
# Run from your ROM source root, AFTER repo sync / trees.sh / hals.sh.
#
# StatiX inherits LineageOS' qcom-caf infrastructure but not vendor/lineage,
# which is what normally wires it up.  These are the pieces that live in
# StatiX's own repos, so they cannot be shipped from a local manifest.
set -e

GUIDE_PATCHES="${GUIDE_PATCHES:-$(dirname "$(readlink -f "$0")")/patches}"

echo "Applying StatiX fixes for Sapphire..."

# --- 1. Drop the sm8450 audio stack -----------------------------------------
# StatiX's include-caf.xml ships vendor/qcom/opensource/{pal,agm} for sm8450.
# They are plain projects with no os_pickup guard, so Soong always parses them
# and collides with the sm6225 stack: "module already defined".
rm -rf vendor/qcom/opensource/pal vendor/qcom/opensource/agm

# --- 2. Replace the QTI power HAL -------------------------------------------
# StatiX's copy (branch "vic") is the old Android.mk HAL pinned to
# android.hardware.power-V1-ndk; the Android 16 compatibility matrix rejects
# IPower V1.  It also predates the "qtipower" Soong config namespace the device
# tree drives.  Without a usable IPower/default the framework NPEs in
# HintManagerService and system_server crash-loops until init reboots.
rm -rf vendor/qcom/opensource/power
git clone --depth 1 -b lineage-23.2 \
    https://github.com/LineageOS/android_vendor_qcom_opensource_power.git \
    vendor/qcom/opensource/power

# --- 3. Empty display namespace stub ----------------------------------------
# hardware/qcom-caf/common/os_pickup_qssi.bp is linked into the Android.bp of
# every guarded CAF platform and declares a soong_namespace importing
# vendor/qcom/opensource/display, which StatiX ships no project for.  Soong
# fails namespace resolution even though none of those platforms are built.
mkdir -p vendor/qcom/opensource/display
cat > vendor/qcom/opensource/display/Android.bp <<'BP'
// Empty namespace stub: os_pickup_qssi.bp imports this namespace for the
// guarded CAF platforms.  sapphire uses hardware/qcom-caf/sm6225/display.
soong_namespace {
}
BP

# --- 4. Signing certificates ------------------------------------------------
# StatiX's release keys are private, so these two symlinks dangle in a public
# checkout and the sepolicy insertkeys step fails.  Point them at AOSP's test
# keys.  NOTE: builds made this way are signed with public test keys -- fine
# for testing, NOT for distribution or OTAs.
ln -sfn ../../../../build/make/target/product/security/nfc.x509.pem \
    vendor/statix-prebuilts/apex/certificates/nfc.x509.pem
ln -sfn ../../../../../../build/make/target/product/security/bluetooth.x509.pem \
    vendor/statix/build/target/product/security/bluetooth.x509.pem

# --- 5. Source patches ------------------------------------------------------
apply() {
    local repo="$1" patch="$2"
    if git -C "$repo" apply --check --reverse "$patch" 2>/dev/null; then
        echo "  already applied: $(basename "$patch")"
    else
        git -C "$repo" apply "$patch" && echo "  applied: $(basename "$patch")"
    fi
}

apply packages/apps/Statix/Launcher "$GUIDE_PATCHES/0001-StatixLauncher-android16.patch"
apply packages/apps/Launcher3      "$GUIDE_PATCHES/0002-Launcher3-widgetpicker-visibility.patch"
apply device/statix/sepolicy       "$GUIDE_PATCHES/0003-sepolicy-lineage-health-fastcharge.patch"

echo "============================"
echo "StatiX fixes applied successfully"
echo "============================"
