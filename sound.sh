#!/bin/bash

echo -e '\033[10;750]\033[11;100]'

freq=0
while : ; do
  freq=$((freq+1))
  echo -e "\033[10;$freq]"
  echo "frequence=$freq"
  # beep
  echo -e '\a'
  usleep 100
done

