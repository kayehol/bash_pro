#!/bin/bash

while getopts ":sa:" option
do
  case $option in
    s) echo "OK Simple option (-s)";;
    a) echo "OK Argument option (-a), received: $OPTARG";;
    \?) echo "ERROR Invalid option: $OPTARG";;
    :) echo "ERROR Missing argument for $OPTARG";;
  esac
done

echo
shift $((OPTIND - 1))
echo "INDEX: $OPTIND"
echo "REST: $*"
echo
