#!/usr/bin/env bash

check_app_badge() {
    local app_name="$1"
    badge=$(osascript -e "tell application \"System Events\" to tell process \"Dock\" to try
        return value of attribute \"AXStatusLabel\" of UI element \"$app_name\" of list 1
    on error
        return 0
    end try" 2>/dev/null)

    if [[ "$badge" == "missing value" || "$badge" == "0" ]]; then
        badge=""
    fi

    echo "$badge"
}

get_apps_from_dock() {
    osascript -e "tell application \"System Events\"
        get name of every process whose visible is true
    end tell" 2>/dev/null
}

if [ -z "$NAME" ]; then
    exit 1
fi

declare -A ICONS=(
    ["Slack"]="󰒱"
    ["Dropbox"]=""
    ["Discord"]="󰙯"
    ["Teams"]="󰊻"
    ["Microsoft Outlook"]="󰴢"
    ["Mattermost"]="󱧍"
)
ICON="${ICONS["$NAME"]}"

APP_LIST=$(get_apps_from_dock)
LABEL=$(check_app_badge "$NAME")
ICON_COLOR=""

if [[ $LABEL == "" ]]; then
    ICON_COLOR="0xFFA6DA95"
elif [[ $LABEL == "•" ]]; then
    ICON_COLOR="0xFFEED49F"
elif [[ $LABEL =~ ^[0-9]+$ ]]; then
    ICON_COLOR="0xFFED8796"
else
    ICON_COLOR="0xF0A8A8A8"
fi

# If the app is in the dock, show the icon and label; otherwise, hide them
if [ "${NAME}" != "" ] && [[ $APP_LIST == *"$NAME"* ]]; then
    sketchybar -m --set "$NAME" icon.drawing=on label.drawing=on icon="${ICON}" label="${LABEL}" icon.color="${ICON_COLOR}"
else
    sketchybar -m --set "$NAME" icon.drawing=off label.drawing=off
fi
