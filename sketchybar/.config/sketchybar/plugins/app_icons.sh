#!/bin/bash

# Toggle app icons in the bar if they are running or not.

PROCESSES=(
    "dropbox"
    "slack"
    "discord"
)

for process in "${PROCESSES[@]}"; do

    process_num=$(ps aux | grep -v grep | grep -ci "${process}")

    if [ "${process_num}" -gt 0 ]; then
        sketchybar -m --set $process icon.drawing=on
    else
        sketchybar -m --set $process icon.drawing=off
    fi
done

