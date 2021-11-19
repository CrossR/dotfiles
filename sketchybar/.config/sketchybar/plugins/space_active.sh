#!/bin/bash

ACTIVE_SPACES=$(yabai -m query --spaces | jq -r '.[] | [.index] | @sh')

echo $ACTIVE_SPACES

for i in {1..10}; do
    echo "Checking $i"
    if [[ "${ACTIVE_SPACES[*]}" =~ "${i}" ]]; then
        echo "$i active!"
        sketchybar -m --set space${i} icon.drawing=on
    else
        echo "$i not active!"
        sketchybar -m --set space${i} icon.drawing=off
    fi
done


