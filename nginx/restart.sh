#!/bin/bash
#   restart local nginx
#
        
if [ ! -e "/opt/conf/nginx/nginx.pid" ] ; then
    touch /opt/conf/nginx/nginx.pid
fi
        
kill -TERM `cat /opt/conf/nginx/nginx.pid`
sleep 1
/opt/apps/nginx/sbin/nginx -t -c /opt/conf/nginx/nginx-sce.conf
sleep 1
/opt/apps/nginx/sbin/nginx -c /opt/conf/nginx/nginx-sce.conf
ps -fw -p `cat /opt/conf/nginx/nginx.pid` --ppid `cat /opt/conf/nginx/nginx.pid`