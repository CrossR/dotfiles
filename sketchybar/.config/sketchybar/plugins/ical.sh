#!/bin/bash

update() {

    args=()
    SEP="%"
    COUNTER=0
    EVENTS="$(icalBuddy -eed -n -nc -nrd -ea -iep datetime,title -b '' -ps "|${SEP}|" eventsToday)"
    args+=(--remove '/ical.event\.*/')

    # Comment this if-section out if you don't want the time of the next event next to the icon
    if [ "${EVENTS}" != "" ]; then
        IFS="${SEP}" read -ra event <<< "$(echo "${EVENTS}" | head -n1)"
        args+=(--set $NAME label=" ${event[1]}")
    else
        args+=(--set $NAME label="")
    fi

    while read -r line; do
        COUNTER=$((COUNTER + 1))
        if [ "${line}" != "" ]; then
            IFS="${SEP}" read -ra event_parts <<< "$line"
            time="${event_parts[1]}"
            title="${event_parts[0]}"
        else
            time="No events today"
            title=":)"
        fi
        args+=(--clone ical.event.$COUNTER ical.template               \
               --set ical.event.$COUNTER                               \
               label="$title"                                          \
               icon="$time"                                            \
               icon.color=0xFFFE8019                                   \
               click_script="sketchybar --set $NAME popup.drawing=off" \
               position=popup.ical
               drawing=on)
    done <<< "$(echo "$EVENTS")"

    sketchybar -m "${args[@]}" > /dev/null

    if [ "$SENDER" = "forced" ]; then
        sketchybar --animate tanh 15 --set "$NAME" label.y_offset=5 label.y_offset=0
    fi
}

popup() {
    sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
    "routine"|"forced") update
        ;;
    "mouse.clicked") popup toggle
        ;;
esac
