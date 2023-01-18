#!/bin/bash

urgency() {
    time_difference=$1
    colour=""

    case ${time_difference} in
        30|2[0-9]|1[0-9]|[0-9]) colour=0XFFFF0000 ;;
        3[1-9]|4[0-9]|5[0-9]) colour=0XFFFF8D00 ;;
        6[0-9]|7[0-9]|8[0-9]) colour=0XFFFEEF5D ;;
        9[0-9]|10[0-9]|11[0-9]) colour=0XFFBCFE5D ;;
        12[0-9]|13[0-9]|14[0-9]) colour=0XFF5DFE67 ;;
        0|-*) colour=0XFF91D2FF ;;
        *) colour=0XF0A8A8A8
    esac

    echo $colour
}

update() {

    SEP="%"
    COUNTER=0
    EVENTS="$(icalBuddy -eed -n -nc -nrd -ea -iep datetime,title -b '' -ps "|${SEP}|" eventsToday)"

    args=()
    args+=(--remove '/ical.event\.*/')

    CURRENT_TIME=$(date +%s)
    CURRENT_LABEL=$(sketchybar --query ical | jq .label.value)
    CURRENT_COLOUR=$(sketchybar --query ical | jq .label.color | tr '[:lower:]' '[:upper:]')
    LABEL_CHANGED=0

    # Comment this if-section out if you don't want the time of the next event next to the icon
    if [ "${EVENTS}" != "" ]; then
        IFS="${SEP}" read -ra event <<< "$(echo "${EVENTS}" | head -n1)"

        event_time=$(date -j -f %H:%M ${event[1]} +%s)
        time_difference=$(( (event_time - CURRENT_TIME) / 60))
        time_colour=$(urgency $time_difference)

        if [ " ${event[1]}" != ${CURRENT_LABEL} ]; then
            LABEL_CHANGED=1
        fi

        if [ "${time_colour}" != ${CURRENT_COLOUR} ]; then
            LABEL_CHANGED=1
        fi

        args+=(--set $NAME icon.color=${time_colour} label=" ${event[1]}" label.color=${time_colour})
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

        event_time=$(date -j -f %H:%M ${time} +%s)
        time_difference=$(( (event_time - CURRENT_TIME) / 60))
        time_colour=$(urgency $time_difference)

        args+=(--clone ical.event.$COUNTER ical.template               \
               --set ical.event.$COUNTER                               \
               label="$title"                                          \
               label.color=$time_colour                                \
               icon="$time"                                            \
               icon.color=0xFFFE8019                                   \
               click_script="sketchybar --set $NAME popup.drawing=off" \
               position=popup.ical                                     \
               drawing=on)

    done <<< "$(echo "$EVENTS")"

    if [ $LABEL_CHANGED -eq 1 ]; then
        args+=(--animate tanh 15 --set "$NAME" label.y_offset=5 label.y_offset=-5 label.y_offset=0)
    fi

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
