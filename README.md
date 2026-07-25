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

# 🚀 Download Scripts Directly Into Your ROM Source

Run this inside your ROM source root:

```bash
curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/sapphire-bringup/main/trees.sh \
-o tools/sapphire/trees.sh

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/sapphire-bringup/main/hals.sh \
-o tools/sapphire/hals.sh

chmod +x trees.sh hals.sh
```

Run the scripts:

```bash
bash trees.sh
bash hals.sh
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
# Clone Device Trees for Sapphire
echo "Cloning Device Trees for Sapphire..."

rm -rf device/xiaomi/sapphire-kernel
git clone --depth 1 -b lineage-23.2 https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sapphire-kernel.git device/xiaomi/sapphire-kernel

rm -rf device/xiaomi/sepolicy
git clone --depth 1 -b 16 https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sepolicy.git device/xiaomi/sepolicy

rm -rf device/xiaomi/sapphire
git clone --depth 1 -b lineage-23.2 https://github.com/The-Angel-Place-Sapphire/device_xiaomi_sapphire.git device/xiaomi/sapphire

rm -rf vendor/xiaomi/sapphire
git clone --depth 1 -b lineage-23.2 https://github.com/The-Angel-Place-Sapphire/vendor_xiaomi_sapphire.git vendor/xiaomi/sapphire

rm -rf hardware/xiaomi
git clone --depth 1 -b lineage-23.2 https://github.com/The-Angel-Place-Sapphire/android_hardware_xiaomi.git hardware/xiaomi

rm -rf hardware/dolby
git clone --depth 1 https://github.com/The-Angel-Place-Sapphire/hardware_dolby.git hardware/dolby

echo "============================"
echo "Device Trees cloned successfully"
echo "============================"
```

---

# ⚙️ HALs Script (`hals.sh`)

```bash
# Clone HALs for SM6225
echo "Cloning HALs for SM6225..."

rm -rf hardware/qcom-caf/common
git clone --depth 1 -b lineage-23.2 https://github.com/sapphire-sm6225/android_hardware_qcom-caf_common.git hardware/qcom-caf/common

rm -rf hardware/qcom-caf/sm6225/audio/agm
git clone --depth 1 -b lineage-22.2-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_agm.git hardware/qcom-caf/sm6225/audio/agm

rm -rf hardware/qcom-caf/sm6225/audio/pal
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_arpal-lx.git hardware/qcom-caf/sm6225/audio/pal

rm -rf hardware/qcom-caf/sm6225/data-ipa-cfg-mgr
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_data-ipa-cfg-mgr.git hardware/qcom-caf/sm6225/data-ipa-cfg-mgr

rm -rf hardware/qcom-caf/sm6225/dataipa
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/vendor_qcom_opensource_dataipa.git hardware/qcom-caf/sm6225/dataipa

rm -rf hardware/qcom-caf/sm6225/display
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/hardware_qcom_display.git hardware/qcom-caf/sm6225/display

rm -rf hardware/qcom-caf/sm6225/media
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/hardware_qcom_media.git hardware/qcom-caf/sm6225/media

rm -rf hardware/qcom-caf/sm6225/audio/primary-hal
git clone --depth 1 -b lineage-22.0-caf-sm6225 https://github.com/sapphire-sm6225/hardware_qcom_audio.git hardware/qcom-caf/sm6225/audio/primary-hal

rm -rf device/qcom/sepolicy_vndr/sm6225
git clone --depth 1 -b lineage-23.0-caf-sm6225 https://github.com/sapphire-sm6225/device_qcom_sepolicy_vndr.git device/qcom/sepolicy_vndr/sm6225

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

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/sapphire-bringup/main/local_manifest.xml \
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

    <remote
        name="theangelplace"
        fetch="https://github.com/The-Angel-Place-Sapphire" />

    <!-- Device Trees -->

    <project
        path="device/xiaomi/sapphire-kernel"
        name="device_xiaomi_sapphire-kernel"
        remote="theangelplace"
        revision="lineage-23.2" />

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

    <project
        path="hardware/dolby"
        name="hardware_dolby"
        remote="theangelplace"
        revision="lineage-23.2" />

    <!-- HALs -->

    <project
        path="hardware/qcom-caf/common"
        name="android_hardware_qcom-caf_common"
        remote="theangelplace"
        revision="lineage-23.2" />

    <project
        path="hardware/qcom-caf/sm6225/audio/agm"
        name="vendor_qcom_opensource_agm"
        remote="theangelplace"
        revision="lineage-22.2-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/audio/pal"
        name="vendor_qcom_opensource_arpal-lx"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/data-ipa-cfg-mgr"
        name="vendor_qcom_opensource_data-ipa-cfg-mgr"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/dataipa"
        name="vendor_qcom_opensource_dataipa"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/display"
        name="hardware_qcom_display"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/media"
        name="hardware_qcom_media"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="hardware/qcom-caf/sm6225/audio/primary-hal"
        name="hardware_qcom_audio"
        remote="theangelplace"
        revision="lineage-22.0-caf-sm6225" />

    <project
        path="device/qcom/sepolicy_vndr/sm6225"
        name="device_qcom_sepolicy_vndr"
        remote="theangelplace"
        revision="lineage-23.0-caf-sm6225" />

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
