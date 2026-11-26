# SSH server + MSYS2 zsh on a Windows box

`sshd_config` and `etc.zshenv` are verbatim copies of `C:\ProgramData\ssh\sshd_config` and MSYS2's `C:/msys64/etc/zsh/zshenv` - diff against them to see what drifted.

## Install the SSH Server

```powershell
$cap = (Get-WindowsCapability -Online -Name 'OpenSSH.Server*').Name
Add-WindowsCapability -Online -Name $cap
```

If it fails with **"The source files could not be found"**: that is usually a pending servicing operation, not a real download problem.
**Reboot and retry** — that is what fixed it here.
Check `Get-Content C:\Windows\Logs\DISM\dism.log -Tail 40` for the real HRESULT; `0x800f0954` means WU access is blocked, `0x800f081f` means no payload for the build.
This machine has no WSUS or servicing policy, so neither applied.

```powershell
Set-Service -Name sshd -StartupType Automatic; Start-Service sshd
```

## Firewall

The install scopes `OpenSSH-Server-In-TCP` to the **Private** profile only, so on a Public-classified NIC SSH is silently unreachable while sshd runs and listens correctly.
Setting the rule to `Any` makes the classification irrelevant and immune to re-classification:

```powershell
Set-NetFirewallRule -Name OpenSSH-Server-In-TCP -Profile Any -RemoteAddress 132.64.0.0/16
```

`132.64.x.x` is publicly routable, not NAT space, so `RemoteAddress` is what actually limits exposure.
It is wanted whatever the profile, which is why reclassifying the network as Private saves no work — you would still run this command, minus two words.
Reclassifying also enables every other Private-profile rule on a routable subnet (File and Printer Sharing, Network Discovery), and a category is bound to network identity, so a new lease or gateway can silently flip it back to Public and kill SSH.

Verify both parts stuck — `Set-NetFirewallRule` can quietly reset filters:

```powershell
Get-NetFirewallRule -Name OpenSSH-Server-In-TCP | Get-NetFirewallAddressFilter
```

## Key-only authentication

`owner` is a **local administrator**, so sshd reads `C:\ProgramData\ssh\administrators_authorized_keys` and **ignores** `~/.ssh/authorized_keys`.
Both steps are required or the key is rejected with nothing useful logged:

```powershell
'ssh-ed25519 AAAA... comment' | Out-File -FilePath C:\ProgramData\ssh\administrators_authorized_keys -Encoding ascii -Append
icacls.exe C:\ProgramData\ssh\administrators_authorized_keys /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"
```

ACL must end up as **only** `NT AUTHORITY\SYSTEM:(F)` and `BUILTIN\Administrators:(F)`.
Use `-Encoding ascii`, not `utf8` — PowerShell 5.1 writes a BOM.

The config itself is tracked as `windows/ssh/sshd_config`.
Two things that file cannot tell you on its own: the hardening directives must stay **above** the `Match Group administrators` block — the file *ends* with that block, so appending puts them inside it and they apply to admins only, leaving every other account with password login — and `KbdInteractiveAuthentication no` is load-bearing, because this server really does advertise `keyboard-interactive`.

Validate before restarting with:

```powershell
& 'C:\Windows\System32\OpenSSH\sshd.exe' -T -C user=owner,host=localhost,addr=127.0.0.1 | Select-String 'authorizedkeysfile|passwordauth|pubkeyauth|kbdinteractive'
```

Expect `authorizedkeysfile __PROGRAMDATA__/ssh/administrators_authorized_keys`.

Finally, Config changes need:

```powershell
Restart-Service sshd
```

Confirm the hardening from outside; this can't prompt, so it can only report what the server advertises:

```powershell
ssh -o BatchMode=yes -o PubkeyAuthentication=no -o PreferredAuthentications=password owner@QOG-SERVER exit
```

Want `Permission denied (publickey).` — if `password` or `keyboard-interactive` still appear in that list, the restart didn't take.

## MSYS2 zsh as the default shell

```powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\msys64\usr\bin\zsh.exe" -PropertyType String -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShellCommandOption -Value "-c" -PropertyType String -Force
```

`DefaultShellCommandOption` is required.
Without it sshd uses cmd.exe's `/c` convention and `ssh lab "some command"` breaks.
Takes effect on the next connection; no service restart needed.

Revert (also needs no restart):

```powershell
Remove-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell, DefaultShellCommandOption
```

Note that the default shell cannot take arguments such as `--login`, and that can make a difference in the ZSH session you get from SSH and when launching it locally.

### The HOME problem — the one that actually matters

**sshd injects `HOME` as the Windows profile directory** (`C:\Users\owner`), overriding the MSYS2 passwd entry.
Confirm with `getent passwd owner`, which says `/home/owner`; there is no Windows `HOME` env var anywhere.
Local mintty sessions are unaffected, which is what makes this confusing.

Consequence: zsh resolves `$HOME/.zshenv` to `/c/Users/owner/.zshenv`, finds nothing, and the entire config chain is bypassed.

The fix must be in `/etc/zsh/zshenv` (tracked as `windows/ssh/etc.zshenv`).
That is the only file zsh reads *before* it resolves `$HOME/.zshenv`, so it cannot live in this repo's `.zshenv` — a chicken-and-egg that is easy to get wrong and appears to work until you test a fresh session:

```zsh
if [[ -n $SSH_CONNECTION && -d /home/$USER ]]; then
  export HOME=/home/$USER
  export MSYSTEM=${MSYSTEM:-UCRT64}
  cd $HOME
fi
```

Verify with a *new* connection:

```powershell
ssh lab "echo HOME=$HOME ZDOTDIR=$ZDOTDIR MSYSTEM=$MSYSTEM PWD=$PWD"
```

Want `HOME=/home/owner ZDOTDIR=/home/owner/.files MSYSTEM=UCRT64 PWD=/home/owner`.

`/etc/zsh/zshenv` is package-managed.
A zsh update may replace it and leave a `.pacnew`, silently dropping this.
**If SSH sessions ever revert to the Windows profile home, look there first.**

#### Why `HOME` is not set in `sshd_config` instead

`SetEnv HOME=C:/msys64/home/owner` is a recognised keyword — a temp-file `sshd -T -f` parses it with exit 0 — but moving the fix there would not let you drop the `/etc/zsh/zshenv` block, for a reason that has nothing to do with environment variables:

**OpenSSH chdirs to the home directory from the passwd entry, not to `$HOME`.**
On Win32-OpenSSH that is the Windows profile, so the session's working directory would stay `/c/Users/owner` - no matter what's the value of `HOME`.
The `cd $HOME` in `/etc/zsh/zshenv` is what makes `ssh lab ls -l .files` resolve against `/home/owner`.

So `sshd_config` is strictly less capable here, and splitting the fix across two places would mean two places to check.
`PermitUserEnvironment` (default `no`) has the same limitation; it would at least read `~/.ssh/environment`, which the junction maps into the version-controlled `.files/.ssh/`, but it is also a documented security loosening.

## Gotchas worth remembering

- **scp/sftp use Windows paths.**
  The SFTP subsystem is a native Windows binary that bypasses the shell entirely, so `scp file lab:name` works and `scp file lab:/c/Users/owner/name` fails with "No such file or directory" — regardless of zsh being the login shell.
- **Nested quoting through ssh is unreliable.**
  `ssh lab zsh -ic '...'` loses the inner quotes and drops into an interactive shell that hangs.
  For anything non-trivial use `powershell -NoProfile -EncodedCommand <base64>`, which has no quoting surface at all.
- **SSH sessions for `owner` get a High Mandatory Level (elevated) token**, so `HKLM` writes work remotely over ssh without any extra elevation step.
- **The machine PATH had been overwritten** down to 128 characters (only IVI/VISA and CMake; `System32` gone), most likely by a lab instrument installer.
  Repair by writing `HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path` with `Set-ItemProperty -Type ExpandString`.
  **Never** use `setx` (truncates at 1024 chars) or `[Environment]::SetEnvironmentVariable` (downgrades the type to `REG_SZ`, killing `%SystemRoot%` expansion).
  Verify with `(Get-Item '<key>').GetValueKind('Path')` → must be `ExpandString`.
- **Registry env changes don't broadcast.**
  UAC-elevated processes read a fresh environment from the registry at launch, so a new admin terminal sees changes immediately; Explorer-descended shells stay stale until Explorer restarts or `WM_SETTINGCHANGE` is broadcast.
  Services and SSH sessions read from the registry, so they are fine either way.
- `Ethernet 7` (`192.168.137.1`) is Internet Connection Sharing — that is the machine's own address, not a switch.
  `Ethernet 6` is APIPA.
  The campus NIC is `Ethernet 5`.
- The IP is DHCP, not reserved.
  A reservation on MAC `2C-58-B9-10-5D-34` would be the robust fix; currently the LLMNR name tracks the lease instead.
- **LLMNR drops queries occasionally.**
  Seen in practice: `ssh: Could not resolve hostname qog-server`, with an immediate retry resolving fine.
  It is multicast without DNS-style retry semantics, so transient misses are expected — fall back to the IP, and treat a DNS record or DHCP reservation as the real cure.
