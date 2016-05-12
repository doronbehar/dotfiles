# `setup` function:
# 1. The function reads a file located in ~/.sh/environment.csv and decides according
#    to the argument to which place to go. The argument corresponds to the 1st column
#    in the csv file.
# 2. Afterwards it load variables from the makefile located in that directory.
# 3. Then, it prints `ls -l` && `git status`
setup(){
	local SHOW="==========================================
showing releavent files for the project:
=========================================="
	IFS=$'\n'
	while read -r line; do
		if [ "$1" = "$(echo "$line" | cut -d',' -f1)" ]; then
			eval cd "$(echo "$line" | cut -d',' -f2)"
			if [ -f makefile ]; then
				grep --color=never '=' makefile | grep -v '\$' | while read -r l; do
					export $l
				done
			fi
			echo "$SHOW"
			# ment for working with directories containing files for Quartus IDE
			LC_ALL=en_us ls --color=auto -ldh `ls --color=never | egrep -v "(rpt|xml|pin|mpf|jdi|mti|cr|greybox_tmp|vstf|wlf|done|smsg|summary|bak|sld|db|simulation|transcript|qar|qws|qpf)"`
			git status
		fi
	done < ~/.sh/environment.csv
	IFS=$OLDIFS
}
# quartus function:
# The function makes it easier to call Quartus' IDE executables
# Explanation:
# The normal "QUIARTUS_BIN" directory is full of executables like:
# 1. quartus_sh
# 2. quartus_eda
# 3. quartus_drc
# So the point is that it's hard and annoying to type the underscore "_"
# every time you want to use these executables. This function is supposed
# to help you so you can type for example `quartus sh` and it will run quarts_sh
# from that directory. 
# As well, it automatically puts the --64 argument to each one of these executables
# so you will always stay with the 64 function
quartus(){
	local ERROR="Error: check the environmental variable \"QUARTUS_BIN\".
       It should be a path to where you quartus\' executables.
       It can be for example: /opt/altera/quartus/bin.
           **Note**: Don't put an extra / at the end of the path."
	if [ -z "$QUARTUS_BIN" ]; then
		if [ -d "/opt/altera/quartus/bin" ]; then
			QUARTUS_BIN="/opt/altera/quartus/bin"
		else
			echo "$ERROR"
			return 1
		fi
	fi
	if [ "$1" = "gui" ] || [ "$1" = "--gui" ] || [ "$1" = "-g" ]; then
		command $QUARTUS_BIN/quartus --64bit "${@:2}"
	elif [ "$1" = "" ]; then
		echo "Usage:\n--gui | -g | gui for the gui"
		echo `ls $QUARTUS_BIN/quartus_* | cut -d'_' -f2`;
	else
		#IFS=$'\n'
		#for EXTENSION in $(ls $QUARTUS_BIN/quartus_* | cut -d'_' -f2); do
		#	if [ "$1" = "$EXTENSION" ]; then
		#		command $QUARTUS_BIN/quartus_$EXTENSION --64bit "${@:2}"
		#	fi
		#done
		#IFS=$OLDIFS
		command $QUARTUS_BIN/quartus_"$1" --64bit "${@:2}"
	fi
}
# make man with `less` be more colorfull
# taken from wiki.archlinux.org
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
# Make insync easier to be used for insync - command line interface
#available commands
insync(){
	case "$1" in
		"status" )
			command insync get_status
			;;
		"st" )
			command insync get_status
			;;
		* )
			command insync `echo "$@" | sed 's/\s/_/g'`
		;;
	esac
}
