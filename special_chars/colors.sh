#!/bin/bash

# lines
for letter in 0 1 2 3 4 5 6 7; do
  # turn on/off bright color
  for brightness in '' ';1'; do
    # columns
    for background in 0 1 2 3 4 5 6 7; do
      seq="4$background;3$letter"
      # set color
      echo -e "\033[$seq${brightness}m\c"
      # show color
      echo -e " $seq${brightness:-  } \c"
      # turn off color
      echo -e "\033[m\c]"
    # break line
    done; echo
  done
done
