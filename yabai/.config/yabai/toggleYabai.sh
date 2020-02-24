#!/bin/bash

SUCCESS=0

if pgrep -x "yabai" > /dev/null; then
    brew services stop yabai
else
    brew services start yabai
fi

return ${SUCCESS} 2> /dev/null || exit ${SUCCESS}

