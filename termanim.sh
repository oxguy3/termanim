#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Please specify an animation directory"
  exit
fi

# default settings
FRAME_TIME=0.2
LOOP_COUNT=-1
LOOP_TIME=0

# allow animation to override settings
animpath="/anim.conf"
if [ -f $1$animpath ]; then
  source $1$animpath
fi

framepath="/*.frame"
iter=0

while [ "$iter" -le "$LOOP_COUNT" ] || [ "$LOOP_COUNT" -eq "-1" ]; do
  for f in $1$framepath; do
    clear
    cat $f
    sleep $FRAME_TIME
  done
  sleep $LOOP_TIME
done
