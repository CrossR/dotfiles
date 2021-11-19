#!/bin/bash

# Setup some global variables
OPTIND=1 # Reset so getopts works!
SUCCESS=0
FAIL=1

GIT_DIR="${HOME}/git"
TOOLS="${HOME}/tools"

GRN='\033[1;32m'
YEL='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Colour

LogMessage() {
    echo -e "${GRN}$(date +'%d/%m/%Y %X') : INFO    : $*${NC}"
}
#!/usr/bin/env bash

sketchybar -m --set $NAME label="$(date '+%A %d. %b')"
