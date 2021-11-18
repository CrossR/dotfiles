#!/bin/bash

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $CHARGING != "" ]]; then
  sketchybar -m --set battery \
    icon.color=0xFF5DFE67 \
    icon= \
    label=$(printf "${BATT_PERCENT}%%")
  exit 0
fi

case ${BATT_PERCENT} in
    100|9[0-9]|8[0-9]) COLOR=0xFF5DFE67 ;;
    7[0-9]|6[0-9]) COLOR=0xFFBCFE5D ;;
    5[0-9]|4[0-9]) COLOR=0xFFFEEF5D ;;
    3[0-9]|2[0-9]) COLOR=0xFFFF8D00 ;;
    1[0-9]|*) COLOR=0xFFFF0000
esac

case ${BATT_PERCENT} in
    100) ICON="" ;;
    9[0-9]) ICON="" ;;
    8[0-9]) ICON="" ;;
    7[0-9]) ICON="" ;;
    6[0-9]) ICON="" ;;
    5[0-9]) ICON="" ;;
    4[0-9]) ICON="" ;;
    3[0-9]) ICON="" ;;
    2[0-9]) ICON="" ;;
    1[0-9]) ICON="" ;;
    *) ICON=""
esac

sketchybar -m --set battery \
    icon.color=${COLOR} \
    icon=${ICON} \
    label=$(printf "${BATT_PERCENT}%%")
