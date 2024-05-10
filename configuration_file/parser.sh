#!/bin/bash

CONFIG=$1

if [ -z "$CONFIG" ]; then
	echo Usage: parser file.conf
	exit 1
elif [ ! -r "$CONFIG" ]; then
	echo Error: Could not read file $CONFIG
	exit 1
fi

while read LINE; do
	# ignore comments
	[ "$(echo $LINE | cut -c1)" = '#' ] && continue

	# ignore white lines
	[ "$LINE" ] || continue

	set - $LINE
	key=$(echo $1 | tr a-z A-Z)
	shift
	value=$*

	echo "CONF_$key=\"$value\""

done <"$CONFIG"
