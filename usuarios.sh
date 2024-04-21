#!/bin/bash

USE_MSG="
Usage: $(basename "$0") OPTIONS 

OPTIONS:
-d, --delimiter C Use character C as delimiter
-r, --reverse     Reverse listing 
-s, --sort        Sort listing alphabetically
-u, --uppercase   Show uppercase listing

-h, --help        Show help and exit
-V, --version     Show version and exit
"
sort=0
reverse=0
uppercase=0
delim='\t'

while test -n "$1"
do
  case "$1" in
    -h | --help)
      echo "$USE_MSG"
      exit 0
    ;;

    -V | --version)
      echo -n $(basename "$0") 
      grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
      exit 0
    ;;

    -s | --sort) sort=1 ;;

    -r | --reverse) reverse=1 ;;

    -u | --upercase) uppercase=1 ;;

    -d | --delimiter) 
      shift
      delim="$1" 

      if test -z "$delim"
      then
        echo "Missing argument for -d"
        exit 1
      fi 
    ;;

    *)
      echo Invalid option: $1
      exit 1
    ;;
  esac

  shift
done

list=$(cut -d : -f 1,5 /etc/passwd)

test "$order" = 1 && list=$(echo "$list" | sort)

test "$reverse" = 1 && list=$(echo "$list" | tac)

test "$uppercase" = 1 && list=$(echo "$list" | tr a-z A-Z)

echo "$list" | tr : "$delim"

