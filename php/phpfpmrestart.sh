#!/bin/bash

if [ -d /opt/apps/php/lib/php/extensions/no-debug-non-zts-20090626 ]
then
	export LD_LIBRARY_PATH=/opt/apps/php/lib/php/extensions/no-debug-non-zts-20090626
fi

pid=`cat /opt/conf/fpmpid`
kill -TERM $pid
sleep 1
/opt/apps/php/sbin/php-fpm -y /opt/conf/php-fpm.conf
