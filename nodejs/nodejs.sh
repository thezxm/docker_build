#!/bin/bash

main="$1"

cd /opt/src/app; forever start -l /opt/logs/app_${_app.appid}.log -o /opt/logs/stdout_${_app.appid}.log -e /opt/logs/stderr_${_app.appid}.log --pidFile /opt/conf/forever.pid -a $main
