$exe = Join-Path $env:USERPROFILE 'Tools\GlassDock.exe'
if (-not (Test-Path -LiteralPath $exe)) {
  $exe = Join-Path (Split-Path -Parent $PSScriptRoot) 'bin\GlassDock.exe'
}
if (-not (Test-Path -LiteralPath $exe)) {
  throw "GlassDock.exe not found. Run scripts\install.ps1 first."
}

$p = Get-Process GlassDock -ErrorAction SilentlyContinue
if (-not $p) {
  Start-Process -FilePath $exe
  Start-Sleep 6
}
$p = Get-Process GlassDock -ErrorAction SilentlyContinue
if ($p) { try { $p.PriorityClass = 'AboveNormal' } catch {} }
