#!/bin/bash

# Toggle app icons in the bar if they are running or not.

PROCESSES=(
    "/Applications/Dropbox.app/Contents/MacOS/Dropbox"
    "/Applications/Discord.app/Contents/MacOS/Discord"
    "/Applications/Microsoft Teams.app/Contents/MacOS/Teams"
    "/Applications/Microsoft Outlook.app/Contents/MacOS/Microsoft Outlook"
    "/Applications/Mattermost.app/Contents/MacOS/Mattermost"
)

ICONS=(
    ""
    "ﭮ"
    "󰊻"
    "󰴢"
    "󱧍"
)

ICON_STRING=""

for (( i=0; i<${#PROCESSES[@]}; i++ )); do

    process=${PROCESSES[$i]}
    icon=${ICONS[$i]}

    process_num=$(ps aux | grep -v grep | grep -ci "${process}")

    if [ "${process_num}" -gt 0 ]; then
        ICON_STRING="${icon}  ${ICON_STRING}"
    fi
done

if [ "${ICON_STRING}" != "" ]; then
    sketchybar -m --set apps icon.drawing=on icon="$ICON_STRING"
else
    sketchybar -m --set apps icon.drawing=off
fi
