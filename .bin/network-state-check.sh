#!/usr/bin/env bash

NET_CONNECTION="$1"

# find out the current host
if [[ "$HOST" == localhost ]]; then
	if type termux-wifi-connectioninfo 2>&1 > /dev/null; then
		CURRENT_HOST="PHONE"
	else
		exit 1
	fi
else
	CURRENT_HOST="$HOST"
fi

get_ipv4_mask(){
	ip addr | awk '{
		NON_FOUND=1
		if ($0 ~ /state UP/) {
			getline
			getline
			print $4
			NON_FOUND=0
			exit 0
		}
	}
	END{
		if (NON_FOUND){
			print "non"
		}
	}'
}

get_wifi_network(){
	case "$CURRENT_HOST" in
		NUX)
			connmanctl services | awk '{
				if ($0 ~ /\*/) {
					print $2
					exit
				}
			}'
			;;
		ARCHPI)
			# Archpi is always at home
			echo "Behar"
			;;
		ZENIX)
			iwctl station wlan0 get-networks | grep -o Behar
			;;
	esac
}

case "$CURRENT_HOST" in
	NUX|ARCHPI|ZENIX)
		if [[ "$NET_CONNECTION" == "home" ]]; then
			[[ "$(get_wifi_network)" == "Behar" ]] || [[ "$(get_wifi_network)" == "Wired" ]]
			exit $?
		elif [[ "$NET_CONNECTION" == hotspot ]]; then
			[[ "$(get_wifi_network)" == "DORON-hotspot" ]]
			exit $?
		elif [[ "$NET_CONNECTION" == myDorms ]]; then
			[[ "$(get_wifi_network)" == "HOTBOX-1BD4" ]]
			exit $?
		fi
		;;
	PHONE)
		if [[ "$NET_CONNECTION" == "home" ]]; then
			[[ "$(get_ipv4_mask)" == "192.168.14.255" ]]
		elif [[ "$NET_CONNECTION" == "hotspot" ]]; then
			[[ "$(get_ipv4_mask)" == "192.168.43.255" ]]
			exit $?
		fi
		;;
	*)
		exit 1
		;;
esac

