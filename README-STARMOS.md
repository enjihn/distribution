# StarmOS RP6 Alpha (SM8550)

Supported target:
- Retroid Pocket 6 (SM8550, ARM64)

This is **not SteamOS** and is **not affiliated with Valve**. StarmOS is a ROCKNIX-based build that uses ROCKNIX’s existing Steam integration.

## Alpha status
- This is an **alpha** build intended for early testing on RP6/SM8550 only.

## Install (recommended)
1. Download the StarmOS RP6 Alpha image artifact from GitHub Actions for `SM8550`.
2. Flash it to a microSD card.
3. Boot the RP6 from the microSD card.
4. Configure Wi‑Fi.
5. Run `Tools -> Install StarmOS to Internal`.
6. When prompted whether to copy existing `/storage`, answer **y**.
7. Reboot, remove the SD card, and boot from internal storage.

## Warning: Android userdata reset
- Installing to internal storage will erase the device’s Android/internal userdata. Back up anything important before proceeding.

## Steam provisioning (first boot)
- StarmOS uses ROCKNIX’s existing `/usr/config/modules/Install Steam.sh`.
- Steam runtime/client components are **downloaded on first boot provisioning** into `/storage` (no Steam payloads are baked into the image).
- Provisioning is gated to avoid downloading Steam content onto the microSD live environment:
  - By default, provisioning only runs after internal install is detected/marked.
  - An explicit override marker can be created by advanced users at `/storage/.config/starmos/allow-provision-on-sd` (not recommended).

## Game Mode
- StarmOS Game Mode launches ROCKNIX’s existing `/usr/bin/start_steam.sh` via `starmos-gamemode.service`.
- After three failed Steam launches, StarmOS enters recovery mode instead of repeatedly restarting.

## Recovery commands
- `starmos-healthcheck`
- `starmos-recovery`
- `starmos-disable-gamemode`
- `starmos-enable-gamemode`

## Splash / logos
- The issue’s attached splash image could not be fetched in this build environment, so a simple placeholder StarmOS splash/logo was generated under:
  - `projects/ROCKNIX/packages/plymouth-lite/splash/`
  - `distributions/ROCKNIX/logos/`
- TODO before release: replace the placeholder splash/logo assets with the intended StarmOS artwork.

## GitHub Actions build (SM8550 only)
1. Go to `Actions` -> `Build`.
2. Click `Run workflow`.
3. Select branch `codex/starmos-rp6-alpha`.
4. Set `SM8550` to `true` and leave all other devices `false`.

## Known limitations
- Internal-install completion detection is heuristic: it relies on markers copied into `/storage` during internal install and a best-effort check to avoid provisioning while booted from SD.
- Proton and anti-cheat limitations apply as with ROCKNIX/Steam on ARM; no global Proton forcing is applied.
