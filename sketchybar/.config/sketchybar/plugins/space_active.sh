#!/bin/bash

ACTIVE_SPACES=$(yabai -m query --spaces | jq -r '.[] | [.index] | @sh')

for i in {1..9}; do

    if [[ "${ACTIVE_SPACES[*]}" =~ "${i}" ]]; then
        sketchybar -m --set "space.${i}" drawing=on
    else
        sketchybar -m --set "space.${i}" drawing=off
    fi

done


