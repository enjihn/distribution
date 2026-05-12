Target: StarmOS RP6 Alpha (Retroid Pocket 6, SM8550, ARM64).

Hard rules:
- Do not claim this is SteamOS.
- Do not use Valve branding or Steam Deck logos.
- Do not add Steam credentials, user data, installed games, or downloaded Steam payloads to the image.
- Do not bake a populated `/storage/.local/share/Steam` tree into the image.
- Preserve SSH and existing recovery paths.
- Do not force Proton 11 globally.
- Prefer ROCKNIX’s existing `Install Steam.sh` and `start_steam.sh`.
- Keep shell scripts and package files with LF line endings.
- Keep this RP6/SM8550-only unless explicitly asked otherwise.

