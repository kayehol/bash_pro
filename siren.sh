#!/bin/bash

echo -ne "\033[11;900]" # duration almost 1 sec
while :
do
  echo -ne "\033[10;500]\a" ; sleep 1 # high
  echo -ne "\033[10;400]\a" ; sleep 1 # low
done
