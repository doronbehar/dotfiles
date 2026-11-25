# SSH on Windows

This document guides how to make WSL and/or Msys2 use Windows' OpenSSH client implementation.

## Which OpenSSH

Windows ships an "OpenSSH Client" optional feature in `C:\Windows\System32\OpenSSH\`, but prefer the latest release from <https://github.com/PowerShell/Win32-OpenSSH/releases>, which installs into `C:\Program Files\OpenSSH\`.
The two are separate installations, and those releases leave the Windows feature untouched: at the time of writing the feature is still at 9.5p2 while the release is at 10.4p1.
The gap matters because 9.5p2 has no post-quantum key exchange at all.
As a server it makes every up to date client warn about "store now, decrypt later" attacks, and as a client its `ssh-keyscan` aborts against hosts that offer only post-quantum algorithms, github.com among them, with `choose_kex: unsupported KEX method sntrup761x25519-sha512@openssh.com`.
The installer repoints the `ssh-agent` and the `sshd` services at the new binaries and prepends its own directory to the machine `PATH`, but it leaves the Windows feature installed, and in `PATH` as well.
Both copies therefore stay reachable, so prefer absolute paths wherever it matters, as this document does, and check `ssh -V` whenever it is unclear which one answered.

`FixUserFilePermissions.ps1` and `FixHostFilePermissions.ps1` ship next to the executables, and are the supported way to repair ACLs when ssh starts refusing a key or the config itself with `Bad owner or permissions`.
Editing `~/.ssh/config` with a tool that writes a temporary file elsewhere and renames it into place is enough to trigger that, as the file arrives carrying the ACLs of wherever it was written.

Finally, enable and start the native Windows ssh-agent service:

```powershell
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
```

Two properties of that agent are worth knowing before trusting it with a passphrase.
It implements no agent constraints whatsoever, so both `ssh-add -t <life>` and `ssh-add -c` are refused with `agent refused operation`, and there is no way to ask it to forget a key after a while.
It also keeps unlocked keys under `HKCU\Software\OpenSSH\Agent\Keys`, encrypted but ACL'd so that only the agent itself can read them, and reloads them when the service starts, so a cached passphrase survives reboots.
Upstream considers both intentional rather than bugs, see [issue #1487](https://github.com/PowerShell/Win32-OpenSSH/issues/1487), where a maintainer suggests a scheduled task as the remedy, and [issue #1510](https://github.com/PowerShell/Win32-OpenSSH/issues/1510), closed as a duplicate of a 2018 report.
Both still hold in 10.4p1.

What the agent does support is eviction, with `ssh-add -d <key>` for one key and `ssh-add -D` for all of them.
[`ssh-agent-purge-task.xml`](./ssh-agent-purge-task.xml) runs `ssh-add -D` every thirty minutes and again on shutdown, which bounds the cache to half an hour and leaves nothing in the registry for the next boot:

```powershell
Register-ScheduledTask -TaskName 'ssh-agent-purge' -Xml (Get-Content -Raw .\ssh-agent-purge-task.xml) -Force
```

Windows has no shutdown trigger for a user task, so that half is an event trigger on event 1074 of the `System` log, which `User32` writes when a shutdown is initiated, and it is best effort only - the thirty minute repetition is what actually guarantees the bound.
Registering it needs no elevation, and it runs `ssh-add.exe` through `conhost.exe --headless` so that no console window flashes twice an hour.

Two `ssh_config` notes belong here too.
`AddKeysToAgent` accepts a time value and the client does parse it, but the agent then refuses the constrained add, so on Windows `AddKeysToAgent 1h` quietly means `no` rather than caching for an hour.
And since `ssh_config` uses the *first* obtained value for each parameter, such a default belongs in a `Host *` block at the *end* of the file, where the `Host` blocks above it can still override it.

## Native Windows ssh-agent User Service

Regardless if using Msys2 or WSL, Windows' native `ssh-agent` implementation is a single service shared by every shell on the machine, and that is its whole attraction here.
PowerShell, Msys2 and WSL all reach it through the same named pipe, so a passphrase typed in any one of them counts for all the others, with no per shell agent to start, no `SSH_AUTH_SOCK` to export or forward, and nothing to add again after closing a terminal.
It runs as `LocalSystem` while its keys are kept per user, so anything that queries or clears them has to run as the user who added them, which is why the purge task above is registered for the interactive user and not for `SYSTEM`.

### Msys2

Using msys2's `pacman`-provided `ssh-agent` causes all kinds of issues because Msys2 doesn't really provide anything equivalent to Systemd's user services - common to all running shells msys2 launches.
Hence it is recommended to prepend the Windows Native OpenSSH path to Msys2's `$PATH`.
Assuming you installed OpenSSH from Github per the above description, use:

```sh
insert2PATH "/c/Program Files/OpenSSH"
```

You can clone <https://github.com/doronbehar/.ssh> into `"$env:USERPROFILE\.ssh"`, or if you wish to keep using the `.files/.ssh` git-submodule, you can create a junction so native `ssh.exe` resolves its '`~/.ssh`' to MSYS2's `.files/.ssh`:

```powershell
New-Item -ItemType Junction -Path "$env:USERPROFILE\.ssh" -Target "C:\msys64\home\$env:USERNAME\.files\.ssh"
```

### WSL

WSL can use its own `ssh-agent` and the user Systemd service of it just fine.
However, if you want WSL to also use the same ssh keys and caching of Windows' native ssh-agent, you can use the [`nixos-configs/windows-ssh.nix`](https://gitlab.com/doronbehar/nixos-configs/-/blob/master/windows-ssh.nix) file.
Like with Msys2, don't use a `~/.ssh` directory in the WSL's filesystem - let Windows' native `ssh*.exe` tools find the config & keys in `"$env:USERPROFILE\.ssh"`.
For that to work well, you _will_ need to manage that directory with a native `git.exe`, and not with WSL's `git`, as WSL's Git doesn't know how to set the permissions there correctly for Windows' native `ssh.exe` to accept.
