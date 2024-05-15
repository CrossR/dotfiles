#!/bin/bash

# Show the toggl timer state.

WARN="0xFFFF8D00"
OK="0xFF5DFE67"
MISSING="Log your time!"

if [ -f ${HOME}/.config/toggl ]; then
    export $(xargs < ${HOME}/.config/toggl)
fi

AUTH="$TOGGL_API:api_token"
JSON="Content-Type: application/json"

URL="https://api.track.toggl.com/api/v9"
CURRENT_ENTRY="${URL}/me/time_entries/current"

TOGGL_RESPONSE=$(curl --silent ${CURRENT_ENTRY} -H "${JSON}" -u ${AUTH})

# If we have a response, do something with it.
if [ "${TOGGL_RESPONSE}" != "null" ]; then

    PROJECT=$(echo $TOGGL_RESPONSE | jq -r ".description")

    # Parse out the duration of the current entry.
    # Get the start datetime (UTC), then use that
    # to calculate the duration.
    START_TIME_STR=$(echo $TOGGL_RESPONSE | jq -r ".start")
    START_TIME=$(gdate -d "$START_TIME_STR" +%s)
    CURRENT_TIME=$(gdate -u +%s)
    ELAPSED_TIME=$((CURRENT_TIME - START_TIME))
    DURATION=$(gdate -u -d "@$ELAPSED_TIME" +%H:%M)

    # Project found, show in bar.
    if [ "${PROJECT}" == "" ]; then
        PROJECT="…"
    fi

    sketchybar -m --set toggl icon.color="${OK}" \
                              icon.drawing=on \
                              label.drawing=on \
                              label="${PROJECT} ($DURATION)"

    exit 0
fi

# Project not found...check if its a weekend?
if [ $(date +%u) -gt 5 ]; then
    sketchybar -m --set toggl icon.drawing=off label.drawing=off
    exit 0
fi

# Or outside work hours?
if [ $(date +%H) -lt 9 ] || [ $(date +%H) -ge 17 ]; then
    sketchybar -m --set toggl icon.drawing=off label.drawing=off
    exit 0
fi

# Its not a weekend, or outside of work hours, so warn.
sketchybar -m --set toggl icon.color="${WARN}" \
                          icon.drawing=on \
                          label.drawing=on \
                          label="${MISSING}"
exit 0
