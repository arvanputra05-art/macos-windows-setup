# macOS-Like Windows Setup

Config and assets for a GlassDock-based macOS-like desktop on Windows 11. No administrator rights required.

## Quick start

From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\install.ps1
```

Then start GlassDock with `scripts\start-glassdock.ps1` (or log out/in). Spotlight search is `Win + Space` via Flow Launcher.

## What is included

- `MACOS-SETUP-STATUS.md` — current on-screen state, tuning values, reset steps.
- `config/settings.txt` — GlassDock settings (`IconSize=40`, `MagnifySize=64`, `HideTaskbar=True`, `ShowMenuBar=True`, `DynamicIsland=True`, `AppGenie=True`, custom trash icon line).
- `scripts/install.ps1` — copies config/icons/exe, sets the wallpaper, creates the startup shortcut. Backs up existing `settings.txt` first.
- `scripts/start-glassdock.ps1` — starts GlassDock and sets `AboveNormal` priority.
- `bin/GlassDock.exe` — GlassDock v0.4.13, MIT, SHA256 `BF395E585E8A84CB3FA1AE3B8D5287A84CEC8B694215ED64A1C21F92414EB52A`.
- `assets/icons/trash-whitesur.png` — active trash icon (WhiteSur, GPL-3.0).
- `assets/icons/trash-fluent3d.png` — alternate trash icon (Fluent Emoji, MIT).
- `assets/wallpapers/city-night-wallpaper.jpg` — active Unsplash night-city wallpaper, Fill style.
- `THIRD-PARTY-NOTICES.md`, `LICENSES/`, `LICENSE` — licensing.

## Behavior notes

- Running apps appear automatically in the dock with indicators; genie minimize is enabled.
- Taskbar is hidden by GlassDock and returns when GlassDock quits.
- GlassDock's built-in Dynamic Island pill is enabled (`DynamicIsland=True`) at the top center for media, timers, and alerts.
- Custom trash icon is static: it does not switch between empty/full states. Clicking, dragging to trash, and Empty Trash still work.
- `LiveGlass=False`, `IncludePreviewUpdates=False`, and `TrafficLights=False` are kept to avoid stutter on low-RAM systems.
- No credentials or tokens are stored in this repository.

## Reset to normal Windows

Quit GlassDock, delete `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\GlassDock.lnk`, restore the backed-up `settings.txt.bak` if desired, and set your old wallpaper. See `MACOS-SETUP-STATUS.md` for full reset commands.
