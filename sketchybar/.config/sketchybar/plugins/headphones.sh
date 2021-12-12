#!/bin/bash

DEVICES="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType' | jq '.[0]' | jq '.devices_list' | jq -r '.[] | keys[] as $k | "\($k) \(.[$k] | .device_connected) \(.[$k] | .device_minorType)"' | grep 'Yes' | grep 'Headset')"

if [ "$DEVICES" = "" ]; then
  sketchybar -m --set headphones drawing=off
else
  sketchybar -m --set headphones drawing=on
fi

