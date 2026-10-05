# Purpose of this widget is to insert a `gh pr checkout` command to the
# terminal, with a ZSH `#` comment of the PR title - useful for history
# lookup. The widget is not binded here by default, only created. The
# repository to look for PR tabs of is determined by the current directory's
# `git remote -v` output - any remote (e.g. a fork's `origin` and its
# `upstream`) is matched against, regardless of host.

brotab-git(){
	if ! _command_exists brotab; then
		zle -M "brotab is not installed"
		return
	fi
	if ! _command_exists fzf; then
		zle -M "fzf is not installed"
		return
	fi
	if ! _command_exists gh; then
		zle -M "gh is not installed"
		return
	fi
	local git_error
	if ! git_error="$(git rev-parse --is-inside-work-tree 2>&1)"; then
		zle -M "not inside a git repository: ${git_error}"
		return
	fi
	if [[ -z "$(brotab windows)" ]]; then
		zle -M "brotab has detected no windows"
		return
	fi
	local remote_name remote_url remote_action remote_path
	local -a remote_paths
	git remote -v | while IFS=$' \t' read -r remote_name remote_url remote_action; do
		if [[ "$remote_url" == *"://"* ]]; then
			# URL-like syntax, e.g: https://github.com/owner/repo
			remote_path="${remote_url#*://}"
			remote_path="${remote_path#*/}"
		else
			# scp-like syntax, e.g: git@github.com:owner/repo
			remote_path="${remote_url#*:}"
		fi
		remote_paths+=("${remote_path%.git}")
	done
	# `git remote -v` lists both a `fetch` and a `push` line per remote
	# (usually with the same URL), so dedupe before use.
	remote_paths=(${(u)remote_paths})
	if [[ ${#remote_paths} == 0 ]]; then
		zle -M "no git remotes found for the current repository"
		return
	fi
	local idx title url tab_path
	declare -A prs
	brotab list | while IFS=$'\t' read -r idx title url; do
		# Browser tab URLs are always a proper scheme://host/path URL.
		tab_path="${url#*://}"
		tab_path="${tab_path#*/}"
		# Drop any `#fragment` (e.g. `#issuecomment-123`) or `?query` suffix, so
		# tabs pointing inside a PR are still detected.
		tab_path="${tab_path%%[#?]*}"
		for remote_path in $remote_paths; do
			# Plain glob matching (not a regex), so characters like `.` in
			# remote_path are matched literally rather than as wildcards.
			# `[0-9]##` (requires extendedglob) is glob syntax for "one or
			# more digits", the glob counterpart of regex's `[0-9]+`.
			setopt localoptions extendedglob
			if [[ "$tab_path" == "${remote_path}/pull/"[0-9]## ]]; then
				local title_parts=("${(@s: · :)title}")
				local url_path_parts=(${(s:/:)tab_path})
				prs[${url_path_parts[-1]}]=${title_parts[1]//[^[:ascii:]]/}
				break
			fi
		done
	done
	local cmd="gh pr checkout"
	local new_cursor=$(($CURSOR + "${#cmd}"))
	if [[ ${#prs} == 0 ]]; then
		zle -M "brotab has detected no PR tabs for the current repository"
	else
		local selected_pr=$(printf "%s\t%s\n" ${(kv)prs} | fzf \
			--select-1 \
			--header='Pull Requests' \
			--delimiter='\t' \
			--accept-nth=1 \
			--no-multi
		)
		LBUFFER+="${cmd} ${selected_pr} # ${prs[$selected_pr]}"
		CURSOR="$new_cursor"
	fi
}
zle -N brotab-git

# vim: ft=zsh
