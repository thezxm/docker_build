#!/bin/bash
#
#   is pid running?
#           alexzhang@sohu-inc.com
#

PID_FILE=/opt/conf/pid        
        
running()
{
    local PID=$(cat "$1" 2>/dev/null) || return 1
    kill -0 "$PID" 2>/dev/null
}
        
if [ -f "$PID_FILE" ]; then
    if running $PID_FILE ; then
        echo "RUNNING"
    else
        echo "STOPPED"
    fi
else
    echo "STOPPED"
fi