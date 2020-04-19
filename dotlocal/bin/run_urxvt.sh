#!/bin/sh
urxvtc "$@" -e bash
if [ $? -eq 2 ]; then
  urxvtd -q -o -f
  urxvtc "$@" -e bash
fi

