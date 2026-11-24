# macOS-Like Windows Setup — Final Status

## What is actually on screen now
- **Dock (bottom, glass, centered icons 40px, magnify 64px, spacing 3)**: GlassDock — pinned apps + **running apps appear automatically** with running dots, magnification on hover, genie minimize (disedot ke dock), glass bar
- **Menu bar atas (1280x30 pada 1280x720 / 150% DPI)**: logo, Finder, menu, wifi, baterai, jam, Spotlight (klik = Flow Launcher)
- **Windows taskbar: hidden** by GlassDock itself (`HideTaskbar=True`); restored when GlassDock quits
- **Desktop: completely clean** — desktop icons hidden, wallpaper `Pictures\city-night-wallpaper.jpg` (Unsplash night city, Fill), ASUS ScreenXpert stopped
- **Spotlight search**: `Win + Space` (Flow Launcher, dark, Inter font)
- Dark mode + transparency + night-city wallpaper

## Files that control the look
| File | Purpose |
|---|---|
| `%USERPROFILE%\Tools\GlassDock.exe` | GlassDock v0.4.13 (single exe, MIT, SHA256 `BF395E585E8A84CB3FA1AE3B8D5287A84CEC8B694215ED64A1C21F92414EB52A`) |
| `%APPDATA%\GlassDock\settings.txt` | All dock settings (plain text key=value) |
| `%APPDATA%\GlassDock\Icons\` | Custom trash icons (WhiteSur + Fluent 3D) |
| `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\GlassDock.lnk` | Autostart at login |
| `%APPDATA%\FlowLauncher\Settings\Settings.json` | Spotlight hotkey/theme |
| `%USERPROFILE%\Pictures\city-night-wallpaper.jpg` | Wallpaper aktif — Unsplash night city, tema clean (style Fill) |
| `%USERPROFILE%\Pictures\macwall.jpg` | Wallpaper cadangan |

## Reproduce on this or another PC
- Dari root repo: `powershell -ExecutionPolicy Bypass -File scripts\install.ps1`
- Script menyalin config + ikon ke `%APPDATA%\GlassDock\`, exe ke `%USERPROFILE%\Tools\`, memasang wallpaper Fill, dan membuat shortcut startup. GlassDock akan dimatikan dulu agar config tidak ditimpa saat exit.

## Editing tips (close GlassDock first so it does not overwrite)
- Icon size: `IconSize=40` (dulu 48, sekarang lebih kecil), zoom: `MagnifySize=64` (dulu 80), `Magnify=True`, `DockSpacing=3`
- Glass: `LiveGlass=False` (blur statis, ringan/anti patah-patah; `True` = blur live, lebih berat), `GlassTint=50` (0–100), `Appearance=2`
- Hide/show top bar: `ShowMenuBar=True`
- Extra widgets panels: `Widgets=False`
- Running apps in dock: `ShowRunning=True`, dots `Indicators=True`
- Anti patah-patah: `AppGenie=True` dipertahankan (efek Mac), sedangkan `LiveGlass=False`, `IncludePreviewUpdates=False`, `TrafficLights=False`
- Proses GlassDock diberi prioritas AboveNormal via `scripts\start-glassdock.ps1` di repo ini (dipanggil shortcut startup)
- Pinned apps: lines like `pin=Chrome|app:Chrome` (`app:` uses installed app id or exe path)
- Ikon sampah kustom: file `Icons\trash-whitesur.png` (WhiteSur, bin putih minimalis ala macOS) + baris `icon=Zml4ZWQ6dHJhc2g=|trash-whitesur.png` (hapus baris `icon=` untuk balik ke bawaan; ikon kustom statis, status kosong/penuh tidak berubah). Varian lama `Icons\trash-fluent3d.png` (keranjang kawat 3D) disimpan sebagai cadangan; tinggal ganti nama file di baris `icon=` untuk pakai lagi.
- Restart: `Stop-Process GlassDock -Force` → jalankan `scripts\start-glassdock.ps1` dari repo ini
- Right-click the dock for Dock Settings; right-click an app for Keep in Dock / Remove / Quit

## Installed tools
| Tool | Function | RAM |
|---|---|---|
| GlassDock | Dock with running apps, genie minimize | ~165-215 MB |
| Flow Launcher | Spotlight search | ~60-80 MB |
| Inter font | SF Pro alternative | 0 |

Retired: Rainmeter (stopped, autostart removed — skins still in Documents\Rainmeter), Winstep Nexus (stopped, unused).

## Not done (requires Administrator)
- SecureUxTheme / 7TSP / SF Pro (paid or proprietary fonts) — blocked without admin

## Reset to normal Windows
- Quit GlassDock from its dock/context menu (taskbar returns automatically)
- Remove autostart: delete `Startup\GlassDock.lnk`
- Uninstall Flow Launcher: `winget uninstall Flow-Launcher.Flow-Launcher`
- Rainmeter/Nexus uninstall: `winget uninstall Rainmeter.Rainmeter` ; `winget uninstall WinStep.Nexus`
- Taskbar auto-hide if stuck: StuckRects3 Settings byte[8] = 3, restart Explorer
