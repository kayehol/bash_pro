#!/bin/bash

CONFIG="message.conf"

USE_COLORS=0
COLOR_LETTER=
COLOR_BACKGROUND=
MESSAGE='Default message'

eval $(./parser.sh $CONFIG)

[ "$(echo $CONF_USECOLORS | tr A-Z a-z)" = 'on' ] && USE_COLORS=1
COLOR_BACKGROUND=$(echo $CONF_COLORBACKGROUND | tr -d -c 0-9)
COLOR_LETTER=$(echo $CONF_COLORLETTER | tr -d -c 0-9)
[ "$CONF_MESSAGE" ] && MESSAGE=$CONF_MESSAGE

if [ $USE_COLORS -eq 1 ]; then
	echo -e "\033[$COLOR_BACKGROUND;${COLOR_LETTER}m$MESSAGE\033[m"
else
	echo "$MESSAGE"
fi
