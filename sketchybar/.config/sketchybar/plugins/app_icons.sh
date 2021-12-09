#!/bin/bash

# Toggle app icons in the bar if they are running or not.
# Filter is used to ignore any other matching processes from that app.

PROCESSES=(
    "dropbox"
    "slack"
    "discord"
)

FILTERS=(
    "garcon"
    ""
    ""
)

for (( i=0; i<${#PROCESSES[@]}; i++ )); do

    process=${PROCESSES[$i]}
    filter=${FILTERS[$i]}

    if [ "${filter}" != "" ]; then
        process_num=$(ps aux | grep -v grep | grep -vi "${filter}" | grep -ci "${process}")
    else
        process_num=$(ps aux | grep -v grep | grep -ci "${process}")
    fi

    if [ "${process_num}" -gt 0 ]; then
        sketchybar -m --set $process icon.drawing=on
    else
        sketchybar -m --set $process icon.drawing=off
    fi
done

