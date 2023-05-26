#!/bin/sh
debug=false
if [ $debug ]; then 
   echo 1 $YABAI_WINDOW_ID
fi

: ${SLEEP_SECOND:=1}
title=$(yabai -m query --windows --window ${YABAI_WINDOW_ID} | jq .title | cut -d [ -f 2 | cut -d ] -f 1)
if [ $debug ];then
  echo 2 ${title}
fi

for i in {1..100}
do
  if [ "$title" != '""' ]; then
	break
  else
	sleep $SLEEP_SECOND
	title=$(yabai -m query --windows --window ${YABAI_WINDOW_ID} | jq .title | cut -d [ -f 2 | cut -d ] -f 1)
  fi
done
if [ $debug ]; then
  echo 3 ${title} 
fi

title="${title/~/$HOME}"
if [ $debug ]; then
  echo 4 ${title} 
fi

if [ "$title" == "." ]; then
  absolute=$(pwd)
elif [ "$title" == ".." ]; then
  absolute=$(dirname "$(pwd)")
else
	# absolute=$(cd "$(dirname "${title}")"; pwd)/$(basename "$title")
	absolute=$(cd "$(dirname "${title/'~'/$HOME}")"; pwd)/$(basename "$title")
fi


if [ -e $absolute ];then
if [ $debug ]; then
      echo 5 do $absolute 
fi
  yabai -m window ${YABAI_WINDOW_ID} --toggle float
fi

