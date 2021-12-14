#!/bin/bash

# Toggle app icons in the bar if they are running or not.
# Filter is used to ignore any other matching processes from that app.

PROCESSES=(
    "/Applications/Dropbox.app/Contents/MacOS/Dropbox"
    "slack"
    "discord"
)

ICONS=(
    ""
    ""
    "ﭮ"
)

ICON_STRING=""

for (( i=0; i<${#PROCESSES[@]}; i++ )); do

    process=${PROCESSES[$i]}
    icon=${ICONS[$i]}

    process_num=$(ps aux | grep -v grep | grep -ci "${process}")

    echo "$process, $process_num"

    if [ "${process_num}" -gt 0 ]; then
        ICON_STRING="${icon}  ${ICON_STRING}"
    fi
done

if [ "${ICON_STRING}" != "" ]; then
    sketchybar -m --set apps icon.drawing=on icon="$ICON_STRING"
else
    sketchybar -m --set apps icon.drawing=off
fi
