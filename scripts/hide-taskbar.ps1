Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public class TaskbarHider {
    [DllImport("user32.dll")] public static extern IntPtr FindWindow(string className, string windowName);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr hWnd);
}
'@
while ($true) {
    $tray = [TaskbarHider]::FindWindow("Shell_TrayWnd", $null)
    if ($tray -ne [IntPtr]::Zero) { [TaskbarHider]::ShowWindow($tray, 0) | Out-Null }
    Start-Sleep -Milliseconds 300
}
