#!/bin/bash
pid=`cat /opt/conf/fpmpid`
kill -TERM $pid
sleep 1
/opt/apps/php/sbin/php-fpm -y /opt/conf/php-fpm.conf