# Explicitly Installed Pacman Packages

Generated with:

```sh
pacman -Qsq | while read p; do
  pacman -Qi "$p" | awk '{
    if ($1 == "Name") {
      name=$3
    }
    if ($1 == "Install" && $2 == "Reason" && $4 == "Explicitly" && $5 == "installed") {
      print name
    }
  }'
done > ~/.files/windows-home/msys2-pacman-packages.txt
```

```
base
filesystem
git
make
man-db
mingw-w64-ucrt-x86_64-asciidoctor
mingw-w64-ucrt-x86_64-bat
mingw-w64-ucrt-x86_64-delta
mingw-w64-ucrt-x86_64-diffutils
mingw-w64-ucrt-x86_64-file
mingw-w64-ucrt-x86_64-fzf
mingw-w64-ucrt-x86_64-gcc
mingw-w64-ucrt-x86_64-github-cli
mingw-w64-ucrt-x86_64-go
mingw-w64-ucrt-x86_64-jq
mingw-w64-ucrt-x86_64-lf
mingw-w64-ucrt-x86_64-neovim
mingw-w64-ucrt-x86_64-powersession-rs
mingw-w64-ucrt-x86_64-ripgrep
mingw-w64-ucrt-x86_64-rust
mingw-w64-ucrt-x86_64-tree-sitter
msys2-runtime
openssh
pkgfile
rsync
sshpass
tmux
tree
zsh
```
