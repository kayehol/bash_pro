#!/bin/bash

USE_MSG="
Usage: $(basename "$0") OPTIONS 

OPTIONS:
-d C   Use character C as delimiter
-r     Reverse listing 
-s     Sort listing alphabetically
-u     Show uppercase listing

-h     Show help and exit
-V     Show version and exit
"
sort=0
reverse=0
uppercase=0
delim='\t'

while getopts ":hVd:rsu" option 
do
  case "$option" in
    s) sort=1 ;;

    r) reverse=1 ;;

    u) uppercase=1 ;;

    d) delim="$OPTARG" ;;

    h)
      echo "$USE_MSG"
      exit 0
    ;;

    V)
      echo -n $(basename "$0") 
      grep '^# Version' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
      exit 0
    ;;

    \?)
      echo Invalid option: $OPTARG
      exit 1
    ;;

    :)
      echo Missing argument for: $OPTARG
      exit 1
    ;;
  esac

done

list=$(cut -d : -f 1,5 /etc/passwd)

test "$order" = 1 && list=$(echo "$list" | sort)

test "$reverse" = 1 && list=$(echo "$list" | tac)

test "$uppercase" = 1 && list=$(echo "$list" | tr a-z A-Z)

echo "$list" | tr : "$delim"

