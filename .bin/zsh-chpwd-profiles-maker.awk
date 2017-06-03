#!/bin/awk -f
@load "filefuncs"
BEGIN{
	FS="/"
}
{
	PROFILE_NAME=$NF
# Use '_' instead of '-' in the names of the profiles / taskwarrior project
	gsub(/-/, "_", PROFILE_NAME)
	PROFILE_DIRECTORY=$0
# using "filefuncs" to check for an available `.taskrc` file in the profile's directory
	CUSTOM_TASKRC_FILE=stat(PROFILE_DIRECTORY"/.taskrc", fstat)
	print "zstyle ':chpwd:profiles:"PROFILE_DIRECTORY"(|/|/*)' profile "PROFILE_NAME""
	print "chpwd_profile_"PROFILE_NAME"() {"
	print "	[[ ${profile} == ${CHPWD_PROFILE} ]] && return 1"
	print "	print \"chpwd(): Switching to profile: $profile\""
	if (CUSTOM_TASKRC_FILE >= 0) {
		print "	export TASKRC="PROFILE_DIRECTORY"/.taskrc"
	} else {
		print "	export TASKRC="ENVIRON["XDG_RUNTIME_DIR"]"/zsh-chpwd-"PROFILE_NAME"-taskrc"
	}
	print "}"
	print "chpwd_leave_profile_"PROFILE_NAME"() {"
	print "	[[ ${profile} == ${CHPWD_PROFILE} ]] && return 1"
	print "	print \"chpwd(): Switching to profile: $profile\""
	print "	unset TASKRC"
	print "}"
	if (CUSTOM_TASKRC_FILE < 0) {
		print "include ~/.taskrc.default\nreport.ls.filter=status:pending project:"PROFILE_NAME > ENVIRON["XDG_RUNTIME_DIR"]"/zsh-chpwd-"PROFILE_NAME"-taskrc"
	}
}
