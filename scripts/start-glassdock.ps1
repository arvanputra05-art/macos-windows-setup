$p = Get-Process GlassDock -ErrorAction SilentlyContinue
if (-not $p) {
  Start-Process "C:\Users\ASUS\Tools\GlassDock.exe"
  Start-Sleep 6
}
$p = Get-Process GlassDock -ErrorAction SilentlyContinue
if ($p) { try { $p.PriorityClass = 'AboveNormal' } catch {} }
