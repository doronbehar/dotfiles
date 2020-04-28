#!/bin/sh

# requires:
# - zenity https://github.com/GNOME/zenity
# - youtube-dl https://github.com/ytdl-org/youtube-dl
# - xsel https://github.com/kfish/xsel

set -e

xsel -ob | \
	grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | \
	sort -u | \
	zenity --width 2000 --list --title "Choose urls to download from" --column "URL" | \
	while read url; do
	cd ~/downloads
	if [ -f ~/.cache/youtube-dl-clipboard/last_save_dir ]; then
		last_save_dir=$(cat ~/.cache/youtube-dl-clipboard/last_save_dir)
		if [ -d "$last_save_dir" ]; then
			cd "$last_save_dir"
		fi
	fi
	where_to_save="$(zenity --title="Select where to save the file" --file-selection --confirm-overwrite --file-filter='*.mp4' --save --filename="youtube-dl-download.mp4")"
	location_dir="$(dirname "$where_to_save")"
	mkdir -p ~/.cache/youtube-dl-clipboard
	echo "$location_dir" > ~/.cache/youtube-dl-clipboard/last_save_dir
	youtube-dl --output="$where_to_save" "$url"
done