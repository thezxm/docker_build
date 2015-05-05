#!/bin/bash
if [ -z "$MAIN" ]
then
    MAIN=/opt/src/app/main.py
fi
PID_FILE=/opt/conf/uwsgipid

PID=$(cat "$PID_FILE" 2>/dev/null)
kill -9 "$PID" 2>/dev/null
sleep 2
/opt/apps/python/bin/uwsgi --socket :8080 --wsgi-file $MAIN -d /tmp/tst --pythonpath /opt/src/app --harakiri 30 --uid app --gid app --pidfile $PID_FILE