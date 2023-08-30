#!/usr/bin/env sh

ICON="󰒱"
STATUS_LABEL=$(lsappinfo info -only StatusLabel "Slack")
LABEL=""
ICON_COLOR=""
echo $STATUS_LABEL

if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"
    echo $LABEL

    if [[ $LABEL == "" ]]; then
        ICON_COLOR="0xFFA6DA95"
        echo "None"
    elif [[ $LABEL == "•" ]]; then
        ICON_COLOR="0xFFEED49F"
        echo "General"
    elif [[ $LABEL =~ ^[0-9]+$ ]]; then
        ICON_COLOR="0xFFED8796"
        echo "Directed"
    else
        exit 0
    fi
else
  exit 0
fi

if [ "${ICON_COLOR}" != "" ]; then
    sketchybar -m --set slack icon.drawing=on icon="${ICON}" label="${LABEL}" icon.color="${ICON_COLOR}"
else
    sketchybar -m --set slack icon.drawing=off
fi
