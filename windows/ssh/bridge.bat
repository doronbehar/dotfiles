@echo off
rem Reverse ssh tunnel exposing this machine's sshd through
rem build-box.nix-community.org, so that it can be reached from anywhere with a
rem `ProxyCommand ssh build-box.nix-community.org -- nc -U <the socket below>`.
rem
rem This is the Windows counterpart of ~/.config/systemd/user/ssh-bridge.service,
rem and it replaces it on WSL hosts: since NixOS' ssh here *is* Windows' ssh, the
rem unit ended up running a Windows process anyway, and `-R ...:localhost:22`
rem resolves localhost in that Windows process, which is Windows' own sshd rather
rem than any sshd inside WSL. Running it from Windows makes that explicit, drops
rem the dependency on WSL being up, and lets the key's passphrase be typed by a
rem human instead of living unprotected on disk.
rem
rem Keep this window open: it is both the tunnel and the indication that this
rem machine is currently reachable. Closing it takes the bridge down.
setlocal

rem Must match the socket in the `nc -U` of the ProxyCommand on the client side,
rem which is why it is pinned rather than taken from %COMPUTERNAME% - that is
rem QOG-SERVER here, while the clients know this machine as lab.
set BRIDGE_NAME=lab
set REMOTE=build-box.nix-community.org
set SOCKET=/home/doronbehar/.ssh-bridge-%BRIDGE_NAME%.sock
set SSH="C:\Program Files\OpenSSH\ssh.exe"

title Doron SSH bridge - %BRIDGE_NAME% via %REMOTE%

:loop
rem An unclean disconnect can leave the listener behind, and with
rem ExitOnForwardFailure=yes the next attempt would then fail for as long as it
rem takes the far end to notice. The systemd unit just retried until it cleared;
rem removing it ourselves reconnects immediately instead.
echo [%DATE% %TIME%] clearing a possibly stale %SOCKET%
%SSH% %REMOTE% -- rm -f %SOCKET%

echo [%DATE% %TIME%] connecting, the bridge is up once this line stops moving
%SSH% -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -R %SOCKET%:localhost:22 %REMOTE%

echo [%DATE% %TIME%] bridge went down with exit code %ERRORLEVEL%, retrying in 10s
echo [%DATE% %TIME%] close this window, or press Ctrl+C, to stop retrying
rem Not `timeout`, which refuses to run when stdin is redirected ("Input
rem redirection is not supported") and would turn this retry into a busy loop.
rem `ping -n 11` to the loopback waits about ten seconds wherever it runs.
ping -n 11 127.0.0.1 > nul
goto loop
