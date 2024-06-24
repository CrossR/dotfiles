#!/bin/bash

urgency() {
    time_difference=$1
    colour=""

    case ${time_difference} in
        30|2[0-9]|1[0-9]|[1-9]) colour=0XFFFF0000 ;;
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
    EVENTS_WITH_TIME="$(echo "${EVENTS}" | sed '/\.\.\./d')"

    args=()
    args+=(--remove '/ical.event\.*/')

    CURRENT_TIME=$(date +%s)
    CURRENT_LABEL=$(sketchybar --query ical | jq -r .label.value)
    CURRENT_COLOUR=$(sketchybar --query ical | jq -r .label.color | tr '[:lower:]' '[:upper:]')
    DEFAULT_COLOUR="0xF0A8A8A8"
    LABEL_CHANGED=0

    if [ "${EVENTS_WITH_TIME}" != "" ]; then
        IFS="${SEP}" read -ra event <<< "$(echo "${EVENTS_WITH_TIME}" | head -n1)"

        event_time=$(date -j -f %H:%M ${event[1]} +%s)
        time_difference=$(( (event_time - CURRENT_TIME) / 60))
        time_colour=$(urgency $time_difference)

        if [ " ${event[1]}" != "${CURRENT_LABEL}" ]; then
            LABEL_CHANGED=1
        fi

        if [ "${time_colour}" != "${CURRENT_COLOUR}" ]; then
            LABEL_CHANGED=1
        fi

        args+=(--set $NAME icon.color=${time_colour} label=" ${event[1]}" label.color=${time_colour})
    else
        args+=(--set $NAME label="" icon.color=${DEFAULT_COLOUR} label.color=${DEFAULT_COLOUR})
    fi

    while read -r line; do

        COUNTER=$((COUNTER + 1))
        time_colour=${DEFAULT_COLOUR}

        if [ ${COUNTER} -gt 10 ]; then
            time=""
            title=$(printf "%23s" "...")
        elif [ "${line}" != "" ]; then
            IFS="${SEP}" read -ra event_parts <<< "$line"
            time="${event_parts[1]}"
            title="${event_parts[0]}"

            event_time=$(date -j -f %H:%M ${time} +%s)
            time_difference=$(( (event_time - CURRENT_TIME) / 60))
            time_colour=$(urgency $time_difference)
        else
            time=" "
            title="No upcoming events today"
        fi

        args+=(--clone ical.event.$COUNTER ical.template               \
               --set ical.event.$COUNTER                               \
               label="$title"                                          \
               label.color=$time_colour                                \
               icon="$time"                                            \
               icon.color=0xFFFE8019                                   \
               click_script="sketchybar --set $NAME popup.drawing=off" \
               position=popup.ical                                     \
               drawing=on)

        if [ ${COUNTER} -gt 10 ]; then
            break;
        fi

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
