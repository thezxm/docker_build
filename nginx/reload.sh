#!/bin/bash
        
        
/opt/apps/nginx/sbin/nginx -t -c /opt/conf/nginx/nginx-sce.conf
sleep 1
/opt/apps/nginx/sbin/nginx -c /opt/conf/nginx/nginx-sce.conf -s reload
sleep 1
ps -ef |grep -w nginx
