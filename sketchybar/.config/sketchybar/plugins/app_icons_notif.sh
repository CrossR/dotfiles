#!/usr/bin/env bash

declare -A ICONS=(
    ["Slack"]="󰒱"
    ["Dropbox"]=""
    ["Discord"]="󰙯"
    ["Teams"]="󰊻"
    ["Microsoft Outlook"]="󰴢"
    ["Mattermost"]="󱧍"
)
ICON="${ICONS["$NAME"]}"

STATUS_LABEL=$(lsappinfo info -only StatusLabel "$NAME")
LABEL=""
ICON_COLOR=""

if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"

    if [[ $LABEL == "" ]]; then
        ICON_COLOR="0xFFA6DA95"
    elif [[ $LABEL == "•" ]]; then
        ICON_COLOR="0xFFEED49F"
    elif [[ $LABEL =~ ^[0-9]+$ ]]; then
        ICON_COLOR="0xFFED8796"
    else
        ICON_COLOR="0xF0A8A8A8"
    fi
fi

if [ "${ICON_COLOR}" != "" ]; then
    sketchybar -m --set "$NAME" icon.drawing=on label.drawing=on icon="${ICON}" label="${LABEL}" icon.color="${ICON_COLOR}"
else
    sketchybar -m --set "$NAME" icon.drawing=off label.drawing=off
fi
