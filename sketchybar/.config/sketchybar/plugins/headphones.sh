#!/bin/bash

BT_DEVICES=$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType | .[0]')

if [ "${BT_DEVICES}" == "" ] || [ $(jq '."device_connected" | length' <<< "${BT_DEVICES}") -eq 0 ]; then
  exit 0
fi

DEVICES=$(echo "${BT_DEVICES}" | jq '."device_connected" | .[] | first(.[]) | .device_minorType')

if [ "${DEVICES}" != "" ]; then
  sketchybar -m --set headphones drawing=on
else
  sketchybar -m --set headphones drawing=off
fi

