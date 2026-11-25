<#
.SYNOPSIS
    Installs the ssh bridge icon and its shortcuts for the current Windows user.

.DESCRIPTION
    Copies the ssh/bridge.bat and the ssh/bridge.ico sitting next to this
    script into %USERPROFILE%\.ssh, and creates a "Doron SSH bridge" shortcut
    on the Desktop and in the Start Menu, both pointing at the copied script
    and wearing the copied icon. Running it again overwrites all four, which
    makes it the thing to run after changing any of them - and also means that
    the copies under %USERPROFILE%\.ssh are not a place to edit, as the next
    run discards whatever is there.

    A .bat cannot carry an icon of its own - Windows takes the icon of every
    .bat from the file association - which is why the icon lives on shortcuts
    pointing at the script rather than on the script.

.NOTES
    Paths are resolved relative to this script, not to the current directory,
    so it works from whichever clone it is run from:

        powershell -ExecutionPolicy Bypass -File .\install-ssh/bridge.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$sshDir = Join-Path $env:USERPROFILE '.ssh'
$srcBat = Join-Path $PSScriptRoot 'bridge.bat'
$srcIco = Join-Path $PSScriptRoot 'bridge.ico'
$icon   = Join-Path $sshDir 'bridge.ico'
$bat    = Join-Path $sshDir 'bridge.bat'
$name   = 'Doron SSH bridge.lnk'

foreach ($f in @($srcBat, $srcIco)) {
    if (-not (Test-Path -LiteralPath $f -PathType Leaf)) {
        throw "no $f - this script expects bridge.bat and bridge.ico beside it"
    }
}
if (-not (Test-Path -LiteralPath $sshDir -PathType Container)) {
    throw "no $sshDir - clone the .ssh repository into it first"
}

Copy-Item -LiteralPath $srcBat -Destination $bat -Force
"copied : $bat"
Copy-Item -LiteralPath $srcIco -Destination $icon -Force
"copied : $icon"

$ws = New-Object -ComObject WScript.Shell
$dirs = @(
    [Environment]::GetFolderPath('Desktop'),          # honours a redirected Desktop, OneDrive included
    (Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs')
)
foreach ($dir in $dirs) {
    $lnk = Join-Path $dir $name
    $s = $ws.CreateShortcut($lnk)
    $s.TargetPath       = $bat
    $s.WorkingDirectory = $sshDir
    $s.IconLocation     = "$icon,0"
    $s.Description      = 'Reverse ssh tunnel exposing this machine via build-box.nix-community.org'
    $s.Save()
    "created: $lnk"
}

""
"Windows offers no way to pin from a script - the taskbarpin verb was removed in"
"Windows 10 1809 - so pin it by hand: Start, type its name, right click, Pin to taskbar."
