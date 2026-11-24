param(
  [string]$TargetDir = (Join-Path $env:USERPROFILE 'Tools')
)

$repoRoot = Split-Path -Parent $PSScriptRoot
$glassDockDir = Join-Path $env:APPDATA 'GlassDock'
$iconsDir = Join-Path $glassDockDir 'Icons'
$settings = Join-Path $glassDockDir 'settings.txt'
$startup = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\GlassDock.lnk'
$launcher = Join-Path $PSScriptRoot 'start-glassdock.ps1'
$wallpaper = Join-Path $repoRoot 'assets\wallpapers\city-night-wallpaper.jpg'

$running = Get-Process GlassDock -ErrorAction SilentlyContinue
if ($running) {
  $running | Stop-Process -Force
  Start-Sleep -Seconds 2
}

foreach ($dir in @($glassDockDir, $iconsDir, $TargetDir)) {
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

if (Test-Path -LiteralPath $settings) {
  Copy-Item -LiteralPath $settings -Destination "$settings.bak" -Force
}
Copy-Item -LiteralPath (Join-Path $repoRoot 'config\settings.txt') -Destination $settings -Force
Copy-Item -LiteralPath (Join-Path $repoRoot 'assets\icons\trash-whitesur.png') -Destination (Join-Path $iconsDir 'trash-whitesur.png') -Force
Copy-Item -LiteralPath (Join-Path $repoRoot 'assets\icons\trash-fluent3d.png') -Destination (Join-Path $iconsDir 'trash-fluent3d.png') -Force
Copy-Item -LiteralPath (Join-Path $repoRoot 'bin\GlassDock.exe') -Destination (Join-Path $TargetDir 'GlassDock.exe') -Force

if (-not ('DesktopWallpaper' -as [type])) {
  Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class DesktopWallpaper {
  [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
  public static extern bool SystemParametersInfo(uint action, uint param, string value, uint flags);
}
'@
}
if (-not [DesktopWallpaper]::SystemParametersInfo(0x0014, 0, $wallpaper, 0x03)) {
  throw "Failed to set wallpaper: $wallpaper"
}
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value '10'
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value '0'

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($startup)
$shortcut.TargetPath = 'powershell.exe'
$shortcut.Arguments = '-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "' + $launcher + '"'
$shortcut.WorkingDirectory = $PSScriptRoot
$shortcut.Save()

"Installed GlassDock to $TargetDir"
"Settings: $settings"
"Wallpaper: $wallpaper"
"Startup shortcut: $startup"
"Start GlassDock with: $launcher"
