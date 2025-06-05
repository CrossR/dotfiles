#!/bin/bash

# Show the toggl timer state.

WARN="0xFFFF8D00"
OK="0xFF5DFE67"
MISSING="Log your time!"

# Use osascript to pull the info we need
# from the toggle menu bar app.
#
# This avoids any API rate limits, and is much faster.
DURATION=$(osascript -e '
tell application "System Events" to tell process "Toggl Track"
    try
        get name of menu bar item 1 of menu bar 2
    on error errMsg
        return "Error: Timer text not found (" & errMsg & ")"
    end try
end tell
')
DURATION_RESPONSE=$?

# Fetch the project name (3rd item from the dropdown menu)
PROJECT=$(osascript -e '
tell application "System Events" to tell process "Toggl Track"
    try
        set theStatusIcon to menu bar item 1 of menu bar 2
        set allMenuItems to menu items of menu 1 of theStatusIcon

        if (count of allMenuItems) < 3 then
            return "Error: Project name not found (menu has less than 3 items)."
        end if

        return name of item 3 of allMenuItems
    on error errMsg
        return "Error: Could not get project name (" & errMsg & ")"
    end try
end tell
')
PROJECT_RESPONSE=$?

# If either of the above commands failed, we can't proceed.
if [ ${DURATION_RESPONSE} -ne 0 ] || [ ${PROJECT_RESPONSE} -ne 0 ]; then
    sketchybar -m --set toggl icon.color="${WARN}" \
                              icon.drawing=on \
                              label.drawing=on \
                              label="Script Error!"
    exit 0
fi

# If we have at least some timer text, proceed...
if [ "${TOGGL_RESPONSE}" != "null" ]; then

    # Strip any leading/trailing whitespace from the strings.
    DURATION=$(echo "${DURATION}" | xargs)
    PROJECT=$(echo "${PROJECT}" | xargs)

    # Project not found, add a placeholder.
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
