#!/bin/sh
# echo $YABAI_WINDOW_ID >> /Users/lin/yabai_id
: ${SLEEP_SECOND:=1}
title=$(yabai -m query --windows --window ${YABAI_WINDOW_ID} | jq .title | cut -d [ -f 2 | cut -d ] -f 1)
# echo $(yabai -m query --windows --window ${YABAI_WINDOW_ID}) >> /Users/lin/yabai_window

for i in {1..100}
do
  if [ "$title" != '""' ]; then
	break
  else
	sleep $SLEEP_SECOND
	title=$(yabai -m query --windows --window ${YABAI_WINDOW_ID} | jq .title | cut -d [ -f 2 | cut -d ] -f 1)
  fi
done

title="${title/\~/$HOME}"
# echo $title >> /Users/lin/yabai_title
# echo "done" >> /Users/lin/yabai_fin_for

if [ "$title" == "." ]; then
  absolute=$(pwd)
elif [ "$title" == ".." ]; then
  absolute=$(dirname "$(pwd)")
else
  absolute=$(cd "$(dirname "$title")"; pwd)/$(basename "$title")
fi
# echo $absolute >> /Users/lin/yabai_tmp
if [ -e $absolute ];then
#   echo "${YABAI_WINDOW_ID} toggled" >> /Users/lin/yabai_toggle
  yabai -m window ${YABAI_WINDOW_ID} --toggle float
fi

