#!/bin/bash
#   restart local nginx
#

pidfile=/opt/conf/nginx/nginx.pid

[ ! -f /opt/conf/nginx/nginx-sce.conf ] && { echo nginx-sce.conf not exist!; exit; }

[ -f $pidfile ] && PID=$(cat $pidfile)
[ ! -z "$PID" ] && kill -TERM $PID >/dev/null 2>&1

/opt/apps/nginx/sbin/nginx -c /opt/conf/nginx/nginx-sce.conf -s quit >/dev/null 2>&1

sleep 1
/opt/apps/nginx/sbin/nginx -t -c /opt/conf/nginx/nginx-sce.conf
sleep 1
/opt/apps/nginx/sbin/nginx -c /opt/conf/nginx/nginx-sce.conf
#ps -fw -p `cat /opt/conf/nginx/nginx.pid` --ppid `cat /opt/conf/nginx/nginx.pid`
ps -ef |grep -w nginx
