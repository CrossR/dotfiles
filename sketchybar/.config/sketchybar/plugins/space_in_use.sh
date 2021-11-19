#!/bin/bash

COUNTERS=(¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹)

args=()
while read -r index windows; do
    if [ "$windows" -eq 0 ]; then
        args+=(--set "space${index}" "icon=${index}")
    else
        i=$((windows-1))
        args+=(--set "space${index}" "icon=${index}${COUNTERS[$i]}")
    fi

    # if [[ ${is_full} == "true" ]]; then
    #     sketchybar -m --set space${space} icon.font="Hack Nerd Font:Bold:16.0"
    #     sketchybar -m --set space${space} icon=
    # else
    #     sketchybar -m --set space${space} icon.font='SF Pro:Semibold:14.0'
    #     sketchybar -m --set space${space} icon=${space}
    # fi

done <<< "$(yabai -m query --spaces | jq -r '.[] | [.index, .windows | length] | @sh')"

sketchybar -m "${args[@]}"

