#!/bin/bash
# Set the space icons to:
#  - Number of the space
#  - Number with superscript number of windows
#  - A fullscreen logo for native fullscreen apps

COUNTERS=(¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹)

args=()
while read -r index is_full windows; do

    if [ "$windows" -eq 0 ]; then
        args+=(--set "space${index}" "icon=${index}")
    fi

    if [ "$windows" -gt 0 ] && [ "${is_full}" == "false" ]; then
        i=$((windows-1))
        args+=(--set "space${index}" "icon=${index}${COUNTERS[$i]}")
    fi

    if [[ ${is_full} == "true" ]]; then
        sketchybar -m --set "space${index}" icon.font="Hack Nerd Font:Bold:16.0"
        sketchybar -m --set "space${index}" icon=
    else
        sketchybar -m --set "space${index}" icon.font='SF Pro:Semibold:14.0'
    fi

done <<< "$(yabai -m query --spaces | jq -r '.[] | [.index, ."is-native-fullscreen", (.windows | length)] | @sh')"

sketchybar -m "${args[@]}"

