#!/bin/bash

width=60
column_start=5
line_start=5
text_max_lines=20
distance_bord_text=1
color='33;1'
text_color='32'
#color='33;43'

width_end=$((column_start + width - 1 ))
text_column_start=$((column_start + distance_bord_text + 1))
text_width=$((width - distance_bord_text))
text=$(fmt -sw $text_width)
num_lines=$(echo "$text" | wc -l)
total_lines=$((num_lines + 2))

if [ $num_lines -gt $text_max_lines ];then
  echo "Text is too long, won't fit the screen"
  exit 1
fi

# draw horizontal line
for i in $(seq $((width - 2))); do
  box_line="$box_line-"
done

# clear screen
echo -ne '\033c'

# draw box
echo -ne "\033[$line_start;0H"
# turn on color
echo -ne "\033[${color}m"

for i in $(seq $total_lines); do
  echo -ne "\033[${column_start}G"

  if [ $i -eq 1 -o $i -eq $total_lines ]; then
    # horizontal border
    echo +$box_line+
  else
    # vertical border
    echo -e "|\033[${column_end}G|"
  fi
done
# turn off colors
echo -e '\033[m'

echo -ne "\033[$((line_start + 1));0H"
echo -ne "\033[${color}m"

echo "$text" | while read LINE; do
  echo -e "\033[${text_column_start}G$LINE"
done

echo -e '\033[m'
echo
