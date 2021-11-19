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
done <<< "$(yabai -m query --spaces | jq -r '.[] | [.index, .windows | length] | @sh')"

sketchybar -m "${args[@]}"

