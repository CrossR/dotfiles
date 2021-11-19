#!/bin/bash

ACTIVE_SPACES=$(yabai -m query --spaces | jq -r '.[] | [.index] | @sh')

for i in {1..10}; do

    if [[ "${ACTIVE_SPACES[*]}" =~ "${i}" ]]; then
        sketchybar -m --set space${i} icon.drawing=on
    else
        sketchybar -m --set space${i} icon.drawing=off
    fi

done


