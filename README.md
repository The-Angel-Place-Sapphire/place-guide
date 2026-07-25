# 👋 The Angel Place — Sapphire (SM6225) on StatiX

Bringup for **Xiaomi Redmi Note 13 4G (Sapphire / SM6225)** on **StatiX**
(`bp4a`, Android 16).

This branch is the StatiX counterpart of `main`, which targets AOSP/LineageOS.
The device trees themselves live on the `statix-bp4a` branch of each repo.

> **Read the "StatiX tree patches" section before building.** StatiX inherits
> LineageOS' qcom-caf infrastructure but not `vendor/lineage`, which is what
> normally wires it up. A handful of fixes therefore have to be applied to
> StatiX's own repos — the device trees alone are not enough.

---

# 📦 Repositories

| Component | Repository | Branch |
| --- | --- | --- |
| Device tree | `device_xiaomi_sapphire` | `statix-bp4a` |
| Kernel tree | `device_xiaomi_sapphire-kernel` | `statix-bp4a` |
| SEPolicy | `device_xiaomi_sepolicy` | `statix-bp4a` |
| Vendor tree | `vendor_xiaomi_sapphire` | `statix-bp4a` |
| Xiaomi hardware | `android_hardware_xiaomi` | `statix-bp4a` |
| Dolby hardware | `hardware_dolby` | `statix-bp4a` |
| MiuiCamera (device) | `device_xiaomi_miuicamera-sapphire` | `statix-bp4a` |
| MiuiCamera (vendor) | `vendor_xiaomi_miuicamera-sapphire` | `statix-bp4a` |

All under `https://github.com/The-Angel-Place-Sapphire`.

---

# 🚀 Build

## 1. Init and sync StatiX

```bash
repo init -u https://github.com/StatiXOS/android_manifest.git -b bp4a --git-lfs
```

Add the local manifest:

```bash
mkdir -p .repo/local_manifests

curl -L https://raw.githubusercontent.com/The-Angel-Place-Sapphire/place-guide/statix-bp4a/local_manifest.xml \
  -o .repo/local_manifests/sapphire.xml

repo sync -j$(nproc --all) --force-sync
```

## 2. Apply the StatiX tree patches

See the section below. **The build will not complete without them.**

## 3. Build

```bash
source build/envsetup.sh
lunch statix_sapphire-bp4a-userdebug
m bacon
```

No special environment variables are needed; `vendor/statix/vendorsetup.sh`
sets everything on its own.

The result lands in
`out/target/product/sapphire/statix_sapphire-<date>-16-v9.2-UNOFFICIAL.zip`
and is flashed by sideloading it from recovery.

### Optional: Pixel Launcher

Add to `statix_sapphire.mk`:

```makefile
INCLUDE_PIXEL_LAUNCHER := true
```

This pulls in `NexusLauncherRelease` plus its three overlays. Note that
`StatixLauncher` declares `overrides: ["Launcher3", "Launcher3QuickStep"]`, so
both launchers end up installed and you have to pick one.

---

# 🩹 StatiX tree patches

These live in StatiX's own repos, so they cannot be shipped from a local
manifest. Apply them by hand after syncing. Every one of them is required.

### 1. `vendor/statix/build/core/utils.mk` — qcom board macros

**The most important one.** StatiX spells the qcom board-platform macros in
terms of `PRODUCT_USES_<vendor>_HARDWARE` and `PRODUCT_BOARD_PLATFORM`, whereas
LineageOS — and every qcom `Android.mk` written against it — uses
`BOARD_USES_<vendor>_HARDWARE` and `TARGET_BOARD_PLATFORM`. Nothing in the tree
ever assigns the `PRODUCT_` spellings, so `is-vendor-board-platform` always
evaluates empty and **28 qcom `Android.mk` files are skipped** — silently,
because `PRODUCT_ENFORCE_PACKAGES_EXIST` is off.

That drops the power HAL, the sm6225 audio HAL and the media codecs from the
image. Without a usable `IPower/default` the framework throws a
`NullPointerException` in `HintManagerService`, `system_server` crash-loops, and
init reboots the device after four attempts.

The sapphire device tree works around this by mirroring both variables in
`BoardConfig.mk`, so **no patch is strictly needed for this device** — but
fixing `utils.mk` upstream is the real solution, and any other qcom device on
StatiX hits the same wall.

### 2. `device/statix/sepolicy` — health HAL service context

`hardware/statix`'s health HAL registers both `IChargingControl` **and**
`IFastCharge` with `CHECK_EQ(status, STATUS_OK)`, but only the first is declared
in `service_contexts`. The second `addService` returns -1, the process aborts,
and init reboots the device once it has crashed four times before boot
completes.

In `common/dynamic/service_contexts` add:

```
vendor.lineage.health.IFastCharge/default             u:object_r:hal_lineage_health_service:s0
```

### 3. `packages/apps/Statix/Launcher` — Android 16 catch-up

Their Launcher fork has not been updated for AOSP 16. Three fixes:

* `Android.bp` — add the Compose defaults, which supply either the enabled or
  the disabled facade sources, so they are needed even with Compose off:

  ```
  defaults: [
      "launcher_compose_defaults",
      "quickstep_compose_defaults",
  ],
  ```

* `src/com/statix/launcher/ThemedLocalColorExtractor.java` — AOSP 16 replaced
  the `com.android.systemui.monet.Style` enum with the
  `android.content.theming.ThemeStyle` int constants. Swap the import and use
  `ThemeStyle.VIBRANT`.

* `src/com/statix/launcher/hpapps/HpAppsActivity.java` — `LauncherAppState.INSTANCE`
  is now a `DaggerSingletonObject`, which has no `executeIfCreated()`. Use
  `LauncherAppState.getInstance(this).getModel().forceReload()`.

* `res/layout/launcher.xml` — AOSP 16 moved the page indicator into a container
  alongside two `PaginationArrow` views. `Launcher.setupViews()` resolves
  `left/right_indicator_arrow` unconditionally and calls `setOnClickListener` on
  them, so the overridden layout must include them or the launcher NPEs on every
  start. Copy the `page_indicator_container` block from
  `packages/apps/Launcher3/res/layout/launcher.xml`.

### 4. `packages/apps/Launcher3` — widget picker visibility

With Compose enabled, `launcher_compose_defaults` pulls in
`widget_picker_component`, whose `default_visibility` only covers
`//packages/apps/Launcher3:__subpackages__` and `//vendor:__subpackages__`. Add
`//packages/apps/Statix/Launcher:__subpackages__` in
`modules/widgetpicker/Android.bp`.

### 5. Signing certificates

StatiX's release keys are private, so two symlinks dangle in a public checkout
and the sepolicy `insertkeys` step fails. Point them at the AOSP test keys:

```bash
ln -sfn ../../../../build/make/target/product/security/nfc.x509.pem \
  vendor/statix-prebuilts/apex/certificates/nfc.x509.pem

ln -sfn ../../../../../../build/make/target/product/security/bluetooth.x509.pem \
  vendor/statix/build/target/product/security/bluetooth.x509.pem
```

Builds made this way are signed with the public AOSP test keys. Fine for
testing, **not for distribution or OTAs**.

### 6. `vendor/qcom/opensource/display` — empty namespace stub

StatiX links `hardware/qcom-caf/common/os_pickup_qssi.bp` into the `Android.bp`
of every guarded CAF platform. That file declares a `soong_namespace` importing
`vendor/qcom/opensource/display`, which StatiX ships no project for, so Soong
fails namespace resolution even though none of those platforms are built.
sapphire uses `hardware/qcom-caf/sm6225/display` instead, so an empty namespace
is enough:

```bash
mkdir -p vendor/qcom/opensource/display
printf 'soong_namespace {\n}\n' > vendor/qcom/opensource/display/Android.bp
```

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

---

# 🤝 Contributions

Contributions, fixes, and improvements are welcome.

The StatiX-side patches above are all upstream bugs — none of them are fixed in
StatiX as of this writing, and they are worth sending to their Gerrit.

---

# 👑 Maintained by

**Angelpro09_Dev**
Building Sapphire, one commit at a time.
