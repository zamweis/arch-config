#!/usr/bin/env bash

cardNumber=$(aplay -l|grep 'Sound BlasterX G5'|cut -d' ' -f 2 |tr -d ':')
amixer -c "$cardNumber" -q set "PCM Capture Source" "External Mic"

if [ $? -eq 0 ]; then
  echo -e "PCM Capture Source: \e[32msuccessfully changed to 'External Mic'\e[39m"
else
  echo -e "PCM Capture Source: \e[31mFailed to configure for Sound BlasterX G5\e[39m"
fi
