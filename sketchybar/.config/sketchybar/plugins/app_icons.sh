#!/bin/bash

# Toggle app icons in the bar if they are running or not.
# Filter is used to ignore any other matching processes from that app.

PROCESSES=(
    "dropbox"
    "slack"
    "discord"
)

ICONS=(
    ""
    ""
    "ﭮ"
)

FILTERS=(
    "garcon"
    ""
    ""
)

ICON_STRING=""

for (( i=0; i<${#PROCESSES[@]}; i++ )); do

    process=${PROCESSES[$i]}
    filter=${FILTERS[$i]}
    icon=${ICONS[$i]}

    if [ "${filter}" != "" ]; then
        process_num=$(ps aux | grep -v grep | grep -vi "${filter}" | grep -ci "${process}")
    else
        process_num=$(ps aux | grep -v grep | grep -ci "${process}")
    fi

    echo "$process, $filter, $process_num"

    if [ "${process_num}" -gt 0 ]; then
        ICON_STRING="${icon}  ${ICON_STRING}"
    fi
done

if [ "${ICON_STRING}" != "" ]; then
    sketchybar -m --set apps icon.drawing=on icon="$ICON_STRING"
else
    sketchybar -m --set apps icon.drawing=off
fi
