# SSH on Windows

To make Windows' native `C:\Windows\System32\OpenSSH\ssh.exe` native executable take precedent over msys2's SSH, use:

```sh
insert2PATH "/c/Windows/System32/OpenSSH/"
```

Junction so native `ssh.exe` resolves `~/.ssh` to MSYS2's `.files/.ssh`:

```powershell
New-Item -ItemType Junction -Path "$env:USERPROFILE\.ssh" -Target "C:\msys64\home\$env:USERNAME\.files\.ssh"
```

Enable and start the native Windows ssh-agent service:

```powershell
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
```
