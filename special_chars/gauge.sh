#!/bin/bash

echo -n '[....................................] 0%'

step='#####'

for i in 10 20 30 40 50 60 70 80 90 100; do
  sleep 1
  # current position of bar
  pos=$((i/2-5))

  # start of line
  echo -ne '\033[G'
  echo -ne "\033[${pos}C"
  echo -n "$step"
  # move to pctg position
  echo -ne '\033[53G'
  # print pctg
  echo -n "$i"
done
echo

