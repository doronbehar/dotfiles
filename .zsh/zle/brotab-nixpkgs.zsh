# Purpose of this widget is to insert a nixpkgs-review or a gh command to the
# terminal, with a ZSH `#` comment of the PR title - useful for history lookup.
# The widget is not binded here by default, only created. After the command is
# inserted, the cursor is placed right after the `--systems` argument. The
# default --systems argument used here includes all systems (see NOTE below).

brotab-nixpkgs(){
	if ! _command_exists brotab; then
		zle -M "brotab is not installed"
		return
	fi
	if ! _command_exists fzf; then
		zle -M "fzf is not installed"
		return
	fi
	if [[ -z "$(brotab windows)" ]]; then
		zle -M "brotab has detected no windows"
		return
	fi
	local full_path idx title url
	declare -A prs
	brotab list | while IFS=$'\t' read -r idx title url; do
		full_path="$(echo $url | url-parser pt)"
		if [[ \
			"$(echo $url | url-parser ht)" == "github.com" && \
			"$full_path" =~ "NixOS/nixpkgs/pull/[0-9]+" \
		]]; then
			local title_parts=("${(@s: · :)title}")
			local url_path_parts=(${(s:/:)full_path})
			prs[${url_path_parts[4]}]=${title_parts[1]//[^[:ascii:]]/}
		fi
	done
	local cmd_name=$(echo "gh\nnixpkgs-review" | fzf \
		--header='Nixpkgs command' \
		--no-multi \
	)
	if [[ "$cmd_name" == "nixpkgs-review" ]]; then
		local cmd="nixpkgs-review pr "
		cmd+="--systems 'aarch64-linux x86_64-linux aarch64-darwin x86_64-darwin' "
		local new_cursor=$(($CURSOR + "${#cmd}"))
		cmd+="--post-result"
	elif [[ "$cmd_name" == "gh" ]]; then
		local cmd="gh pr checkout"
		local new_cursor=$(($CURSOR + "${#cmd}"))
	fi
	if [[ ${#prs} == 0 ]]; then
		zle -M "brotab has detected no Nixpkgs PR tabs"
	else
		local selected_pr=$(printf "%s\t%s\n" ${(kv)prs} | fzf \
			--select-1 \
			--header='Nixpkgs Pull Requests' \
			--delimiter='\t' \
			--accept-nth=1 \
			--no-multi
		)
		LBUFFER+="${cmd} ${selected_pr} # ${prs[$selected_pr]}"
		CURSOR="$new_cursor"
	fi
}
zle -N brotab-nixpkgs

# vim: ft=zsh
