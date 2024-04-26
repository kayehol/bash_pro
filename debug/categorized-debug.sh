#!/bin/bash

DEBUG=${1:-0}

Debug(){
  [ $1 -le $DEBUG ] || return
  local prefix
  case "$1" in
    1) prefix="-- ";;
    2) prefix="---- ";;
    3) prefix="------ ";;
    *) echo "Message not cathegorized: $*"; return;;
  esac
  shift

  echo $prefix$*
}

Debug 1 "Program start"

i=0
max=5
echo "Counting to $max"

Debug 2 "Entering WHILE"

while [ $i -ne $max ]; do
  Debug 3 "Value of \$i before increment: $i"

  let i=$i+1

  Debug 3 "Value of \$i after increment: $i"

  echo "$i..."
done

Debug 2 "Left WHILE"

echo 'Finished!'

Debug 1 "End of program"
