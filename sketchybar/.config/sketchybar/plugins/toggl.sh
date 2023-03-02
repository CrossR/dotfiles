#!/bin/bash

# Show the toggl timer state.

ICON="󰁫"
RED="0xFF5DFE67"
DEFAULT="0XF0A8A8A8"

PY_ENV="${HOME}/.virtualenvs/toggl-cli-*/bin/python"
TOG_SCRIPT="${HOME}/tools/software/toggl_cli/get_current.py"
RESULT=$(${PY_ENV} ${TOG_SCRIPT})

IFS=: read -r DESC TIME <<< "${RESULT}"

if [ ${TIME} == "0" ]; then
    sketchybar -m --set toggl icon.drawing=on icon="$ICON" icon.color="${RED}"
    # TODO: Timer based.
else
    sketchybar -m --set toggl icon.drawing=on icon="$ICON" icon.color="${DEFAULT}"
fi
