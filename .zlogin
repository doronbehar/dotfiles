# quartus IDE function
quartus(){
	if [ "$1" = "gui" ] || [ "$1" = "--gui" ] || [ "$1" = "-g" ]; then
		command $QUARTUS_BIN/quartus --64bit "${@:2}" > /dev/null 2>&1 &
	elif [ "$1" = "" ]; then
		echo "Usage:\n--gui | -g | gui for the gui version or:"
		echo `ls $QUARTUS_BIN/quartus_* | cut -d'_' -f2`;
	else
		IFS=$'\n'
		for EXTENSION in $(ls $QUARTUS_BIN/quartus_* | cut -d'_' -f2); do
			if [ "$1" = "$EXTENSION" ]; then
				command $QUARTUS_BIN/quartus_$EXTENSION --64bit "${@:2}"
			fi
		done
		IFS=$OLDIFS
	fi
}

# make man with `less` be more colorfull
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

