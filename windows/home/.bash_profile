# Fixes a peculiar issue with direnv's populated `$PATH` not reaching Bash
# child shells. Claude Code is especially suffering without this workaround, as
# it needs to find executables etc. polulated by direnv when working on
# projects. While writing this comment, I have a slight suspicion that there's
# a better more elegant workaround for this, as this was not needed if I
# remember correctly.
if [[ -n "${DIRENV_DIR:-}" ]]; then
  eval "$(env -u DIRENV_DIR -u DIRENV_DIFF -u DIRENV_FILE "$HOME/repos/direnv/direnv.exe" export bash)"
fi
