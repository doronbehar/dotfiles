#!/bin/sh

if [[ -z $XDG_RUNTIME_DIR && -d $XDG_RUNTIME_DIR ]]; then
	UID="$(id -u)"
	XDG_RUNTIME_DIR="/run/user/"UID
fi
mkdir -p "$XDG_RUNTIME_DIR"/zsh-chpwd-profiles

while read profile; do
	profile_name="$(basename $profile)"
	profile_name="${profile_name//"-"/"_"}"
	profile_dir="$profile"
	echo "zstyle ':chpwd:profiles:$profile_dir(|/|/*)' profile "$profile_name
	echo "chpwd_profile_"$profile_name"() {"
	echo "	[[ \$\{profile\} == \$\{CHPWD_PROFILE\} ]] && return 1"
	echo "	print \"chpwd(): Switching to profile: \$profile\""
	if [[ -f "$profile_dir/.taskrc" ]]; then
		echo "	export TASKRC="$profile_dir"/.taskrc"
	else
		TASKRC_FILE="$XDG_RUNTIME_DIR""/zsh-chpwd-profiles/"$profile_name".taskrc"
		echo "	export TASKRC="$TASKRC_FILE
		if [[ ! -s $TASKRC_FILE ]]; then
			cat <<-EOF > $TASKRC_FILE
			include ~/.taskrc.default
			report.ls.filter=status:pending project:$profile_name -BLOCKED
			EOF
		fi
	fi
	echo "}"
	echo "chpwd_leave_profile_"$profile_name"() {"
	echo "	[[ \$\{profile\} == \$\{CHPWD_PROFILE\} ]] && return 1"
	echo "	print \"chpwd(): Switching to profile: \$profile\""
	echo "	unset TASKRC"
	echo "}"
done < $HOME/.zsh-chpwd-profiles
