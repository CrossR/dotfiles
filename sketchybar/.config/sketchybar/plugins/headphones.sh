#!/bin/bash

DEVICES="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType | .[0] | ."device_connected" | .[] | first(.[]) | .device_minorType')"

if [ "$DEVICES" = "" ]; then
  sketchybar -m --set headphones drawing=off
else
  sketchybar -m --set headphones drawing=on
fi

