# 👋 Welcome to The Angel Place — Sapphire (SM6225)

Welcome to the official bringup repository for **Xiaomi Redmi Note 13 4G (Sapphire / SM6225)**.

This branch covers **AOSPA (Paranoid Android) — `beryl`, Android 16**.

Unlike the LineageOS/AOSP branch, AOSPA bringup is **not just cloning trees**. The device trees and HALs here are LineageOS `lineage-2x-caf-sm6225` variants, while AOSPA carries its own fork of the QCOM common layer. The two collide in several places, so this branch also documents the **patches you must apply to the AOSPA source itself**.

Read the whole guide before syncing. Skipping the AOSPA-side patches will not build.

---

# 🌐 Place-bringups

| ROM | Branch |
| :-- | :-- |
| 🟩 **LineageOS / AOSP** | [`main`](https://github.com/The-Angel-Place-Sapphire/place-guide/tree/main) |
| 🟦 **StatiX (bp4a)** | [`statix-bp4a`](https://github.com/The-Angel-Place-Sapphire/place-guide/tree/statix-bp4a) |
| 🟪 **AOSPA (beryl)** | [`aospa-beryl`](https://github.com/The-Angel-Place-Sapphire/place-guide/tree/aospa-beryl) |

---

# 📦 Main Repositories

All repositories below are on the **`aospa-beryl`** branch.

## 🌳 Device Tree

```bash
https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sapphire
```

## 🌲 Kernel Tree

```bash
https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sapphire-kernel
```

## 🔒 SEPolicy

```bash
https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sepolicy
```

## 📦 Vendor Tree

```bash
https://github.com/The-Angel-Place-Sapphire/vendor_xiaomi_sapphire
```

## ⚙️ Xiaomi Hardware

```bash
https://github.com/The-Angel-Place-Sapphire/android_hardware_xiaomi
```

## 🔊 Dolby Hardware

```bash
https://github.com/The-Angel-Place-Sapphire/hardware_dolby
```

---

# 🚀 Sync AOSPA

```bash
mkdir aospa && cd aospa

repo init -u https://github.com/AOSPA/manifest -b beryl --git-lfs

repo sync -j$(nproc) --force-sync
```

---

# 📄 Local Manifest (recommended)

```bash
mkdir -p .repo/local_manifests

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/place-guide/aospa-beryl/local_manifest.xml \
-o .repo/local_manifests/sapphire.xml

repo sync -j$(nproc) --force-sync
```

The local manifest for this branch also pulls two upstream LineageOS projects that AOSPA does not ship but this device needs:

* `packages/apps/EuiccPolicy` — provides `EuiccPolicy`, required by `XiaomiEuicc`
* `hardware/lineage/interfaces` — provides `vendor.lineage.touch`, required by the Xiaomi touch HAL

---

# ⚡ Quick Start (Manual Setup)

Make sure you are inside your ROM source root directory.

## 🌳 Device Trees Script (`trees.sh`)

```bash
# Clone Device Trees for Sapphire
echo "Cloning Device Trees for Sapphire..."

rm -rf device/xiaomi/sapphire-kernel
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sapphire-kernel.git device/xiaomi/sapphire-kernel

rm -rf device/xiaomi/sepolicy
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sepolicy.git device/xiaomi/sepolicy

rm -rf device/xiaomi/sapphire
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sapphire.git device/xiaomi/sapphire

rm -rf vendor/xiaomi/sapphire
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/vendor_xiaomi_sapphire.git vendor/xiaomi/sapphire

rm -rf device/xiaomi/miuicamera-sapphire
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/device_xiaomi_miuicamera-sapphire.git device/xiaomi/miuicamera-sapphire

rm -rf vendor/xiaomi/miuicamera-sapphire
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/vendor_xiaomi_miuicamera-sapphire.git vendor/xiaomi/miuicamera-sapphire

rm -rf hardware/xiaomi
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/android_hardware_xiaomi.git hardware/xiaomi

rm -rf hardware/dolby
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/hardware_dolby.git hardware/dolby

echo "============================"
echo "Device Trees cloned successfully"
echo "============================"
```

## ⚙️ HALs Script (`hals.sh`)

```bash
# Clone HALs for SM6225
echo "Cloning HALs for SM6225..."

rm -rf hardware/qcom-caf/common
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/android_hardware_qcom-caf_common.git hardware/qcom-caf/common

rm -rf hardware/qcom-caf/sm6225/audio/agm
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/vendor_qcom_opensource_agm.git hardware/qcom-caf/sm6225/audio/agm

rm -rf hardware/qcom-caf/sm6225/audio/pal
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/vendor_qcom_opensource_arpal-lx.git hardware/qcom-caf/sm6225/audio/pal

rm -rf hardware/qcom-caf/sm6225/data-ipa-cfg-mgr
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/vendor_qcom_opensource_data-ipa-cfg-mgr.git hardware/qcom-caf/sm6225/data-ipa-cfg-mgr

rm -rf hardware/qcom-caf/sm6225/dataipa
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/vendor_qcom_opensource_dataipa.git hardware/qcom-caf/sm6225/dataipa

rm -rf hardware/qcom-caf/sm6225/display
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/hardware_qcom_display.git hardware/qcom-caf/sm6225/display

rm -rf hardware/qcom-caf/sm6225/media
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/hardware_qcom_media.git hardware/qcom-caf/sm6225/media

rm -rf hardware/qcom-caf/sm6225/audio/primary-hal
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/hardware_qcom_audio.git hardware/qcom-caf/sm6225/audio/primary-hal

rm -rf device/qcom/sepolicy_vndr/sm6225
git clone --depth 1 -b aospa-beryl https://github.com/The-Angel-Place-Sapphire/device_qcom_sepolicy_vndr.git device/qcom/sepolicy_vndr/sm6225

echo "============================"
echo "HALs cloned successfully"
echo "============================"
```

## 🧩 Extra upstream projects

```bash
rm -rf packages/apps/EuiccPolicy
git clone --depth 1 -b lineage-23.2 https://github.com/LineageOS/android_packages_apps_EuiccPolicy.git packages/apps/EuiccPolicy

# Only the touch interface — do not clone the whole repo over hardware/lineage,
# its health interface collides with AOSPA's own vendor.lineage.health.
rm -rf /tmp/lineage-interfaces
git clone --depth 1 -b lineage-23.2 https://github.com/LineageOS/android_hardware_lineage_interfaces.git /tmp/lineage-interfaces
mkdir -p hardware/lineage/interfaces
cp -r /tmp/lineage-interfaces/touch hardware/lineage/interfaces/touch
```

---

# 🔧 AOSPA-side patches (required)

These live in AOSPA/AOSP projects, so they cannot be shipped as a branch here. Apply them by hand after syncing.

## 1. Product definition

AOSPA has no product for this device. Create `vendor/aospa/products/sapphire/aospa_sapphire.mk`:

```makefile
#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

# Check for target product
ifeq (aospa_sapphire,$(TARGET_PRODUCT))

# QCOM platform - must be visible before device/qcom/common is pulled in
TARGET_BOARD_PLATFORM := bengal

# Inherit from framework configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from sapphire device configuration
$(call inherit-product, device/xiaomi/sapphire/device.mk)

# Inherit from common AOSPA configuration
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier
PRODUCT_NAME := aospa_sapphire
PRODUCT_DEVICE := sapphire
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 13
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sapphire_global-user 15 AQ3A.240829.003 OS2.0.210.0.VNGMIXM release-keys" \
    BuildFingerprint=Redmi/sapphire_global/sapphire:15/AQ3A.240829.003/OS2.0.210.0.VNGMIXM:user/release-keys

endif
```

`TARGET_BOARD_PLATFORM` must be set **here**, not only in `BoardConfig.mk`. `device/qcom/common/common.mk` errors out if the variable is not already visible at product-config time.

Register it in `vendor/aospa/products/AndroidProducts.mk`:

```diff
     $(LOCAL_DIR)/psyche/aospa_psyche.mk \
+    $(LOCAL_DIR)/sapphire/aospa_sapphire.mk \
     $(LOCAL_DIR)/sky/aospa_sky.mk \
```

```diff
     aospa_psyche-userdebug \
+    aospa_sapphire-userdebug \
     aospa_sky-userdebug \
```

## 2. SELinux policy — pick one QCOM set

AOSPA ships `device/qcom/sepolicy_vndr`; this device needs the LineageOS `sm6225` policy. The two overlap by roughly **741 types**, so they cannot both be active. Point AOSPA at the sm6225 tree in `device/qcom/sepolicy_vndr/SEPolicy.mk`:

```diff
-SEPOLICY_PATH:= device/qcom/sepolicy_vndr
+SEPOLICY_PATH:= device/qcom/sepolicy_vndr/sm6225
```

And drop the overlapping vendor dirs in `device/qcom/common/sepolicy/SEPolicy.mk`, keeping the system side:

```diff
-BOARD_VENDOR_SEPOLICY_DIRS += \
-    $(COMMON_SEPOLICY_PATH)/generic/vendor/common \
-    $(COMMON_SEPOLICY_PATH)/qva/vendor/common \
-    $(COMMON_SEPOLICY_PATH)/generic/vendor/$(TARGET_SEPOLICY_DIR) \
-    $(COMMON_SEPOLICY_PATH)/qva/vendor/$(TARGET_SEPOLICY_DIR)
```

Without this you get `unknown type vendor_hal_iop_hwservice`, `unknown type vendor_netmgrd`, and a long tail of similar errors.

## 3. Launcher3 privileged permissions

The AOSPA Launcher3 requests two permissions that its allowlist does not grant, so `system_server` throws `IllegalStateException` in `PackageManagerService.systemReady()` and the device **bootloops**. Add them to `frameworks/base/data/etc/com.android.launcher3.xml`:

```diff
         <permission name="android.permission.ACCESS_HIDDEN_PROFILES_FULL"/>
+        <permission name="android.permission.ACCESS_CONTEXTUAL_SEARCH"/>
+        <permission name="android.permission.FORCE_STOP_PACKAGES"/>
     </privapp-permissions>
```

## 4. Move AOSPA's unused QCOM blobs out of the tree

`vendor/qcom/common` imports the `hardware/qcom/display/gralloc` namespace, which does not exist in this configuration, and soong refuses to parse the tree. Nothing in this device pulls it in (`TARGET_COMMON_QTI_COMPONENTS` is never set), and the device supplies its own adreno blobs:

```bash
mkdir -p ~/aospa_disabled/vendor/qcom
mv vendor/qcom/common ~/aospa_disabled/vendor/qcom/common
```

---

# 🏗️ Build

```bash
source build/envsetup.sh
lunch aospa_sapphire-bp2a-userdebug
m otapackage -j$(nproc)
```

The release config (`bp2a`) is required — Android 16 lunch targets are `product-release-variant`.

Output:

```
out/target/product/sapphire/aospa_sapphire-ota.zip
```

This is an **A/B OTA** (`payload.bin`). Flash it with `adb sideload` from recovery, not fastboot.

---

# 🐞 Known issues

| Issue | Status |
| :-- | :-- |
| `/vendor/bin/STFlashTool` fails to link (`android::base::Trim` missing) | Harmless. ST sensor flashing utility, unused at runtime. |
| `hardware/qcom-caf/bootctrl` | Not needed. AOSPA ships a complete `android.hardware.boot@1.2-impl-qti` in `hardware/qcom/bootctrl`. |

---

# 📌 Notes

Excluded:

* ❌ Signing keys
* ❌ GApps

Recommended:

* Use `ccache`
* Use SSD storage
* Sync with `--force-sync` when switching branches
* If the device factory-resets itself on first boot, wipe data once — RescueParty state persists in `/data` across reboots

---

# 🤝 Contributions

Contributions, fixes, and improvements are welcome.

Feel free to open issues or pull requests.

---

# 👑 Maintained by

**Angelpro09_Dev**
Building Sapphire, one commit at a time.
