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

    if [ "$windows" -eq 0 ] && [ "${is_full}" == false ]; then
        args+=(--set "space${index}" "icon=${index}")
    fi

    filtered_window_num=0

    if [ "$windows" -gt 0 ] && [ "${is_full}" == "false" ]; then
        # Ignore certain windows (mostly ones that persist over every space).
        filtered_window_num=$(
            yabai -m query --windows --space ${index} | \
                jq -r '[.[] | select(
                    .app != "Slack" and
                    .app != "Discord" and
                    .app != "Spotify"
                )] | length | @sh'
        )
    fi

    if [ "${filtered_window_num}" -gt 0 ]; then

        i=$((filtered_window_num - 1))
        args+=(--set "space${index}" "icon=${index}${COUNTERS[$i]}")
    fi

    if [[ ${is_full} == "true" ]]; then
        sketchybar -m --set "space${index}" icon.font="Hack Nerd Font:Bold:20.0"
        sketchybar -m --set "space${index}" icon=
    else
        sketchybar -m --set "space${index}" icon.font='SF Pro:Semibold:14.0'
    fi

done <<< "$(yabai -m query --spaces | jq -r '.[] | [.index, ."is-native-fullscreen", (.windows | length)] | @sh')"

sketchybar -m "${args[@]}"

