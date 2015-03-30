#!/bin/bash

main="$1"

cd /opt/src/app; forever start -l /opt/logs/app_505054297.log -o /opt/logs/stdout_505054297.log -e /opt/logs/stderr_505054297.log --pidFile /opt/conf/forever.pid -a $main
