#!/bin/bash
# Set the space icons to:
#  - Number of the space
#  - Number with superscript number of windows
#  - A fullscreen logo for native full screen apps
#
# Queries the actual windows in each space to filter the results.

COUNTERS=(¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹)

args=()
while read -r index is_full windows; do

    filtered_window_num=0

    if [ "$windows" -gt 0 ] && [ "${is_full}" == "false" ]; then

        # Ignore certain windows (mostly ones that persist over every space).
        filtered_window_num=$(
            yabai -m query --windows --space ${index} | \
                jq -r '[.[] | select(
                    ."is-sticky" == false and
                    ."is-minimized" == false
                )] | length | @sh'
        )
    fi

    if [ "${filtered_window_num}" -gt 0 ]; then
        echo "$index: $filtered_window_num"
        i=$((filtered_window_num - 1))
        args+=(--set "space${index}" "icon=${index}${COUNTERS[$i]}")
    fi

    if [ "$filtered_window_num" -eq 0 ] && [ "${is_full}" == false ]; then
        echo "$index: nothin"
        args+=(--set "space${index}" "icon=${index}")
    fi

    if [[ ${is_full} == "true" ]]; then
        sketchybar -m --set "space${index}" icon.font="Hack Nerd Font:Bold:20.0"
        sketchybar -m --set "space${index}" icon=
    else
        sketchybar -m --set "space${index}" icon.font='SF Pro:Semibold:14.0'
    fi

done <<< "$(yabai -m query --spaces | jq -r '.[] | [.index, ."is-native-fullscreen", (.windows | length)] | @sh')"

sketchybar -m "${args[@]}"

