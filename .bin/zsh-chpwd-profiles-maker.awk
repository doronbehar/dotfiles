#!/bin/awk -f
BEGIN{
	FS="/"
}
{
	PROFILE_NAME=$NF
	gsub(/-/, "_", PROFILE_NAME)
	PROFILE_DIRECTORY=$0
	print "zstyle ':chpwd:profiles:"PROFILE_DIRECTORY"(|/|/*)' profile "PROFILE_NAME""
	print "chpwd_profile_"PROFILE_NAME"() {"
	print "	[[ ${profile} == ${CHPWD_PROFILE} ]] && return 1"
	print "	print \"chpwd(): Switching to profile: $profile\""
	print "	export TASKRC="ENVIRON["XDG_RUNTIME_DIR"]"/zsh-chpwd-"PROFILE_NAME"-taskrc"
	print "}"
	print "chpwd_leave_profile_"PROFILE_NAME"() {"
	print "	[[ ${profile} == ${CHPWD_PROFILE} ]] && return 1"
	print "	print \"chpwd(): Switching to profile: $profile\""
	print "	unset TASKRC"
	print "}"
	print "include ~/.taskrc.default\nreport.ls.filter=status:pending project:"PROFILE_NAME > ENVIRON["XDG_RUNTIME_DIR"]"/zsh-chpwd-"PROFILE_NAME"-taskrc"
}
