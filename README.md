# 👋 Welcome to The Angel Place — Sapphire (SM6225) · StatiX

Welcome to the **StatiX** bringup for **Xiaomi Redmi Note 13 4G (Sapphire / SM6225)**.

This branch provides everything required to initialize the necessary **device trees**,
**HALs** and **StatiX-side fixes** for building **StatiX `bp4a` (Android 16)**.

This project supports **two setup methods**:

* ⚡ Manual setup using scripts
* 📄 Local manifest setup (recommended)

Choose the method that fits your workflow.

> ⚠️ **StatiX needs a third step.** It inherits LineageOS' qcom-caf infrastructure
> but not `vendor/lineage`, which is what normally wires it up. After the trees and
> HALs you **must** run `statix.sh` — see [🩹 StatiX fixes](#-statix-fixes).

---

# 🌐 Place-bringups

| ROM | Branch |
| :-- | :-- |
| 🟩 **LineageOS / AOSP** | [`main`](https://github.com/The-Angel-Place-Sapphire/place-guide/tree/main) |
| 🟦 **StatiX (bp4a)** | [`statix-bp4a`](https://github.com/The-Angel-Place-Sapphire/place-guide/tree/statix-bp4a) |

---

# 📦 Main Repositories

All device trees live on the **`statix-bp4a`** branch.

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

## 📷 MiuiCamera

```bash
https://github.com/The-Angel-Place-Sapphire/device_xiaomi_miuicamera-sapphire
https://github.com/The-Angel-Place-Sapphire/vendor_xiaomi_miuicamera-sapphire
```

---

# 🚀 Download Scripts Directly Into Your ROM Source

Run this inside your ROM source root:

```bash
BASE=https://raw.githubusercontent.com/The-Angel-Place-Sapphire/place-guide/statix-bp4a

curl -L $BASE/trees.sh  -o trees.sh
curl -L $BASE/hals.sh   -o hals.sh
curl -L $BASE/statix.sh -o statix.sh

chmod +x trees.sh hals.sh statix.sh
```

`statix.sh` also needs the patch files:

```bash
mkdir -p patches
for p in 0001-StatixLauncher-android16 \
         0002-Launcher3-widgetpicker-visibility \
         0003-sepolicy-lineage-health-fastcharge; do
  curl -L $BASE/patches/$p.patch -o patches/$p.patch
done
```

Run the scripts:

```bash
bash trees.sh
bash hals.sh
bash statix.sh
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
```

---

# ⚙️ HALs Script (`hals.sh`)

```bash
#!/bin/bash
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
```

---

# 🩹 StatiX fixes

## `statix.sh`

Run **after** the trees and HALs, from the ROM source root. It needs the
`patches/` directory next to it.

```bash
bash statix.sh
```

What it does, and why each step is needed:

### 1. Drops the sm8450 audio stack

StatiX's `include-caf.xml` ships `vendor/qcom/opensource/{pal,agm}` for sm8450.
They are plain projects with no `os_pickup` guard, so Soong always parses them
and collides with the sm6225 stack — `module already defined`.

### 2. Replaces the QTI power HAL

StatiX's copy (branch `vic`) is the old `Android.mk` HAL pinned to
`android.hardware.power-V1-ndk`, and the Android 16 compatibility matrix rejects
IPower V1 (*"is deprecated; requires at least 2"*). It also predates the
`qtipower` Soong config namespace the device tree drives. Without a usable
`IPower/default` the framework throws a `NullPointerException` in
`HintManagerService`, `system_server` crash-loops, and init reboots the device.
The LineageOS `lineage-23.2` revision is Soong-based and reads the `qtipower`
variables the device tree sets.

### 3. Creates an empty display namespace

`os_pickup_qssi.bp` is linked into the `Android.bp` of every guarded CAF
platform and declares a `soong_namespace` importing
`vendor/qcom/opensource/display`, which StatiX ships no project for. Soong fails
namespace resolution even though none of those platforms are built.

### 4. Fixes the signing certificates

StatiX's release keys are private, so `nfc.x509.pem` and `bluetooth.x509.pem`
dangle in a public checkout and the sepolicy `insertkeys` step fails. They are
pointed at the AOSP test keys.

> ⚠️ Builds made this way are signed with the **public AOSP test keys**. Fine for
> testing, **not for distribution or OTAs**.

### 5. Applies the source patches

| Patch | Repo | Fixes |
| :-- | :-- | :-- |
| `0001-StatixLauncher-android16` | `packages/apps/Statix/Launcher` | Compose defaults, `ThemeStyle`, `LauncherAppState.getInstance`, pagination arrows in the overridden layout |
| `0002-Launcher3-widgetpicker-visibility` | `packages/apps/Launcher3` | `widget_picker_component` visibility for StatixLauncher |
| `0003-sepolicy-lineage-health-fastcharge` | `device/statix/sepolicy` | `IFastCharge` service context — without it the health HAL aborts and init reboots the device |

The script is idempotent: already-applied patches are detected and skipped.

## Not scripted: `vendor/statix/build/core/utils.mk`

StatiX spells the qcom board-platform macros in terms of
`PRODUCT_USES_<vendor>_HARDWARE` and `PRODUCT_BOARD_PLATFORM`, whereas LineageOS —
and every qcom `Android.mk` written against it — uses `BOARD_USES_<vendor>_HARDWARE`
and `TARGET_BOARD_PLATFORM`. Nothing in the tree ever assigns the `PRODUCT_`
spellings, so `is-vendor-board-platform` always evaluates empty and **28 qcom
`Android.mk` files are skipped** — silently, because `PRODUCT_ENFORCE_PACKAGES_EXIST`
is off. That drops the power HAL, the sm6225 audio HAL and the media codecs.

The sapphire device tree works around this by mirroring both variables in its
`BoardConfig.mk`, so **no patch is needed for this device**. Fixing `utils.mk`
upstream is the real solution, and any other qcom device on StatiX hits the
same wall.

---

# 📄 Recommended Setup (Local Manifest)

Local manifests are the recommended method for long-term maintenance.

Benefits:

* Cleaner source tree
* Easier updates
* Better repo sync integration
* Better collaboration

## Init StatiX

```bash
repo init -u https://github.com/StatiXOS/android_manifest.git -b bp4a --git-lfs
```

## Download local manifest directly

```bash
mkdir -p .repo/local_manifests

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/place-guide/statix-bp4a/local_manifest.xml \
-o .repo/local_manifests/sapphire.xml
```

## Sync sources

```bash
repo sync -j$(nproc --all) --force-sync
```

The manifest already handles the `pal`/`agm` removals and the power HAL swap, so
after syncing you only need the rest of `statix.sh` (steps 3–5).

---

# 🔨 Building

```bash
source build/envsetup.sh
lunch statix_sapphire-bp4a-userdebug
m bacon
```

No special environment variables are needed — `vendor/statix/vendorsetup.sh`
sets everything on its own.

Output:

```
out/target/product/sapphire/statix_sapphire-<date>-16-v9.2-UNOFFICIAL.zip
```

Flash it by sideloading from recovery.

## Optional: Pixel Launcher

Add to `device/xiaomi/sapphire/statix_sapphire.mk`:

```makefile
INCLUDE_PIXEL_LAUNCHER := true
```

This pulls in `NexusLauncherRelease` plus its three overlays. Note that
`StatixLauncher` declares `overrides: ["Launcher3", "Launcher3QuickStep"]`, so
both launchers end up installed and you have to pick one.

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

# 🐛 Known issues

Not blocking, but unfixed:

* `com.qti.phone` crashes in `NrUwbIconUtils.extractValidBands` — a null 5G NR
  band array on a 4G-only device. Needs a CarrierConfig overlay.
* `vendor.dolby.media.c2@1.0-service` crashes at boot.
* `/vendor/bin/STFlashTool` fails to link (`android::base::Trim`); needs a shim.
* Cosmetic SELinux denials on battery sysfs nodes from `vendor_qti_init_shell`.

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

The StatiX-side fixes above are all upstream bugs — none of them are fixed in
StatiX as of this writing, and they are worth sending to their Gerrit.

---

# 👑 Maintained by

**Angelpro09_Dev**
Building Sapphire, one commit at a time.
