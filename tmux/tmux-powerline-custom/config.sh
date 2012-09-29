#!/bin/sh
# Cofigurations for tmux-powerline.

if [ -z "$PLATFORM" ]; then
  UNAME=$(uname)
  if [ $UNAME == 'Linux' ]; then
    export PLATFORM="linux"
  fi
  if [ $UNAME == 'Darwin' ]; then
    export PLATFORM="mac"
  fi
fi

if [ -z "$USE_PATCHED_FONT" ]; then
	# Useage of patched font for symbols. true or false.
	export USE_PATCHED_FONT="true"
fi
