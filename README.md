# 👋 Welcome to The Angel Place — Sapphire (SM6225)

Welcome to the official bringup repository for **Xiaomi Redmi Note 13 4G (Sapphire / SM6225)**.

This repository provides everything required to initialize the necessary **device trees** and **HALs** for building custom ROMs based on **AOSP / LineageOS**.

This project supports **two setup methods**:

* ⚡ Manual setup using scripts
* 📄 Local manifest setup (recommended)

Choose the method that fits your workflow.

---

# 🌐 Place-bringups

| ROM | Branch |
| :-- | :-- |
| 🟩 **LineageOS / AOSP** | [`main`](https://github.com/The-Angel-Place-Sapphire/place-guide/tree/main) |
| 🟦 **StatiX (bp4a)** | [`statix-bp4a`](https://github.com/The-Angel-Place-Sapphire/place-guide/tree/statix-bp4a) |

---

# 📦 Main Repositories

## 🌳 Device Tree

```bash
https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sapphire
```

## 🌲 Kernel (built from source)

```bash
https://github.com/The-Angel-Place-Sapphire/kernel_xiaomi_sapphire
https://github.com/The-Angel-Place-Sapphire/kernel_xiaomi_sapphire-devicetrees
https://github.com/The-Angel-Place-Sapphire/kernel_xiaomi_sapphire-modules
```

The device tree builds the kernel, modules, dtb and dtbo from these sources.
`device_xiaomi_sapphire-kernel` (prebuilt kernel) is no longer used.

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

## 📷 MIUI Camera

```bash
https://github.com/The-Angel-Place-Sapphire/device_xiaomi_miuicamera-sapphire
https://github.com/The-Angel-Place-Sapphire/vendor_xiaomi_miuicamera-sapphire
```

## 🛠️ XiaomiParts

```bash
https://github.com/The-Angel-Place-Sapphire/packages_apps_XiaomiParts
```

---

# 🚀 Download Scripts Directly Into Your ROM Source

Run this inside your ROM source root:

```bash
mkdir -p tools/sapphire

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/place-guide/main/trees.sh -o tools/sapphire/trees.sh

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/place-guide/main/hals.sh -o tools/sapphire/hals.sh

chmod +x tools/sapphire/trees.sh tools/sapphire/hals.sh
```

Run the scripts:

```bash
bash tools/sapphire/trees.sh
bash tools/sapphire/hals.sh
```

---

# ⚡ Quick Start (Manual Setup)

This method is useful for:

* Fast setup
* Testing
* Temporary build environments
* Quick bringup


Make sure you are inside your ROM source root directory.

---

# 🌳 Device Trees Script (`trees.sh`)

```bash
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
```

---

# ⚙️ HALs Script (`hals.sh`)

```bash
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
```

---

# 📄 Recommended Setup (Local Manifest)

Local manifests are the recommended method for long-term maintenance.

Benefits:

* Cleaner source tree
* Easier updates
* Better repo sync integration
* Better collaboration

## Download local manifest directly

```bash
mkdir -p .repo/local_manifests

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/place-guide/main/local_manifest.xml \
-o .repo/local_manifests/sapphire.xml
```

## Sync sources

```bash
repo sync -j$(nproc) --force-sync
```

---

# 📄 Local Manifest (`local_manifest.xml`)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>

    <remove-project name="LineageOS/android_hardware_qcom-caf_common" />  <!-- hardware/qcom-caf/common: use the sapphire one -->
    <remote
        name="theangelplace"
        fetch="https://github.com/The-Angel-Place-Sapphire" />

    <!-- Kernel (built from source) -->
    <project
        path="kernel/xiaomi/sapphire"
        name="kernel_xiaomi_sapphire"
        remote="theangelplace"
        revision="lineage-23.2" />

    <project
        path="kernel/xiaomi/sapphire-devicetrees"
        name="kernel_xiaomi_sapphire-devicetrees"
        remote="theangelplace"
        revision="lineage-23.2" />

    <project
        path="kernel/xiaomi/sapphire-modules"
        name="kernel_xiaomi_sapphire-modules"
        remote="theangelplace"
        revision="lineage-23.2" />

    <!-- Device Trees -->

    <project
        path="device/xiaomi/sepolicy"
        name="device_xiaomi_sepolicy"
        remote="theangelplace"
        revision="16" />

    <project
        path="device/xiaomi/sapphire"
        name="device_xiaomi_sapphire"
        remote="theangelplace"
        revision="lineage-23.2" />

    <project
        path="vendor/xiaomi/sapphire"
        name="vendor_xiaomi_sapphire"
        remote="theangelplace"
        revision="lineage-23.2" />

    <project
        path="hardware/xiaomi"
        name="android_hardware_xiaomi"
        remote="theangelplace"
        revision="lineage-23.2" />

    <!-- HALs -->

    <project
        path="hardware/qcom-caf/common"
        name="android_hardware_qcom-caf_common"
        remote="theangelplace"
        revision="lineage-23.2">
        <linkfile src="os_pickup_aosp.mk" dest="hardware/qcom/Android.mk" />
        <linkfile src="os_pickup_sepolicy_vndr.mk" dest="device/qcom/sepolicy_vndr/SEPolicy.mk" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/msm8953/Android.bp" />
        <linkfile src="os_pickup.bp" dest="hardware/qcom-caf/msm8998/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sdm660/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sdm845/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8150/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8250/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8350/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8450/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8450-6.6/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8550/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8650/Android.bp" />
        <linkfile src="os_pickup_qssi.bp" dest="hardware/qcom-caf/sm8750/Android.bp" />
    </project>

    <project
        path="hardware/qcom-caf/sm6225/audio/agm"
        name="vendor_qcom_opensource_agm"
        remote="theangelplace"
        revision="lineage-23.2-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/audio/pal"
        name="vendor_qcom_opensource_arpal-lx"
        remote="theangelplace"
        revision="lineage-23.2-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/data-ipa-cfg-mgr"
        name="vendor_qcom_opensource_data-ipa-cfg-mgr"
        remote="theangelplace"
        revision="lineage-23.2-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/dataipa"
        name="vendor_qcom_opensource_dataipa"
        remote="theangelplace"
        revision="lineage-23.2-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/display"
        name="hardware_qcom_display"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/media"
        name="hardware_qcom_media"
        remote="theangelplace"
        revision="lineage-23.2-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/audio/primary-hal"
        name="hardware_qcom_audio"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="device/qcom/sepolicy_vndr/sm6225"
        name="device_qcom_sepolicy_vndr"
        remote="theangelplace"
        revision="lineage-23.2-caf-sm6225" />

    <!-- Used by device_xiaomi_sapphire -->
    <project
        path="hardware/dolby"
        name="hardware_dolby"
        remote="theangelplace"
        revision="16" />

    <project
        path="packages/apps/XiaomiParts"
        name="packages_apps_XiaomiParts"
        remote="theangelplace"
        revision="16.2" />

    <project
        path="device/xiaomi/miuicamera-sapphire"
        name="device_xiaomi_miuicamera-sapphire"
        remote="theangelplace"
        revision="lineage-24.0" />

    <project
        path="vendor/xiaomi/miuicamera-sapphire"
        name="vendor_xiaomi_miuicamera-sapphire"
        remote="theangelplace"
        revision="lineage-24.0" />

</manifest>
```

---

# 🤔 Which method should I use?

Use **Manual Scripts** if:

* You want quick setup
* You are testing
* You are doing temporary builds

Use **Local Manifest** if:

* You maintain ROM sources
* You want easier updates
* You work with a team
* You want cleaner repo management

---

# 📌 Notes

Excluded:

* ❌ Signing keys
* ❌ GApps

Recommended:

* Use `ccache`
* Use SSD storage
* Sync with `--force-sync` when switching branches
* Keep trees and HALs updated regularly

---

# 🤝 Contributions

Contributions, fixes, and improvements are welcome.

Feel free to open issues or pull requests.

---

# 👑 Maintained by

**Angelpro09_Dev**
Building Sapphire, one commit at a time.
