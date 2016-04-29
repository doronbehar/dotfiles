# make grep use colors always when inside a pipeline e.g `less -R`
# as well, always use line numbers when not in a pipeline but do use when not in a pipline
# stolen from: http://unix.stackexchange.com/questions/25546/grep-alias-line-numbers-unless-its-in-a-pipeline/25549
grep(){
	if [[ -t 0 && -t 1 ]]; then
		command grep -n --color=auto "$@"
	else
		command grep --color=always "$@"
	fi
}
# `setup` function:
# 1. The function reads a file located in ~/.sh/environment.csv and decides according
#    to the argument to which place to go. The argument corresponds to the 1st column
#    in the csv file.
# 2. Afterwards it load variables from the makefile located in that directory.
# 3. Then, it prints `ls -l` && `git status`
setup(){
	IFS=$'\n'
	while read -r line; do
		if [ "$1" = "$(echo "$line" | cut -d',' -f1)" ]; then
			eval cd "$(echo "$line" | cut -d',' -f2)"
			if [ -f makefile ]; then
				grep '=' makefile | grep -v '\$' | while read -r l; do
					export $l
				done
			fi
			ls -lh
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
		command $QUARTUS_BIN/quartus --64bit "${@:2}" > /dev/null 2>&1 &
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
		* )
			command insync `echo "$@" | sed 's/\s/_/g'`
		;;
	esac
	#case "$@" in
	#	"accept all new shares"		) command insync accept_all_new_shares;;
	#	"accept share"				) command insync accept_share;;
	#	"add account"				) command insync add_account;;
	#	"force sync"				) command insync force_sync;;
	#	"get account information"	) command insync get_account_information;;
	#	"get account info"			) command insync get_account_information;;
	#	"get actions required"		) command insync get_actions_required;;
	#	"get domain link"			) command insync get_domain_link;;
	#	"get errors"				) command insync get_errors;;
	#	"get file status"			) command insync get_file_status;;
	#	"get new shares" 			) command insync get_new_shares;;
	#	"get private link"			) command insync get_private_link;;
	#	"get proxy"					) command insync get_proxy;;
	#	"get public link" 			) command insync get_public_link;;
	#	"get recent changes"		) command insync get_recent_changes;;
	#	"get root_drive files"		) command insync get_root_drive_files;;
	#	"get sync progress"			) command insync get_sync_progress;;
	#	"get status"				) command insync get_status;;
	#	"status"					) command insync get_status;;
	#	"manage ignore list"		) command insync manage_ignore_list;;
	#	"manage selective sync"		) command insync manage_selective_sync;;
	#	"move folder"				) command insync move_folder;;
	#	"open in gdrive"			) command insync open_in_gdrive;;
	#	"pause syncing"				) command insync pause_syncing;;
	#	"quit"						) command insync quit;;
	#	"reject all new_shares"		) command insync reject_all_new_shares;;
	#	"reject share"				) command insync reject_share;;
	#	"remove account"			) command insync remove_account;;
	#	"remove from insync"		) command insync remove_from_insync;;
	#	"resume syncing"			) command insync resume_syncing;;
	#	"retry_errors"				) command insync retry_errors;;
	#	"set autostart"				) command insync set_autostart;;
	#	"set export option"			) command insync set_export_option;;
	#	"set proxy"					) command insync set_proxy;;
	#	"set selective sync"		) command insync set_selective_sync;;
	#	"share"						) command insync share;;
	#	"start"						) command insync start;;
	#esac
}
