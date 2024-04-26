#!/bin/bash

DEBUG=1

Debug(){
  [ $1 -le $DEBUG ] && echo "---> $*"
  # [ "$DEBUG" = 1 ] && echo -e "\033[33;1m$*\033[m"
}

TXT="scream"
TXT="    $TXT    "
Debug "TXT with spaces    : [$TXT]"
TXT=$(echo "$TXT" | tr ' ' '!')
Debug "TXT with exclamation: [$TXT]"
TXT=$(echo $TXT | tr a-z A-Z)
echo "$TXT"
