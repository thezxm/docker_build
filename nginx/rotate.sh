#!/bin/bash

###Rotate Nginx logs,reserve 2 days;

logpath="/opt/logs"
pid=`cat /opt/conf/nginx/nginx.pid`
today=`date +%Y%m%d`
Day_old=`date +%Y%m%d -d "1 days ago"`

cd $logpath
mkdir -p history
logname=`ls access*  error*`

for log  in  $logname
do
   if [ -s "$log" ] 
   then
       mv -f   $log   history/${log}.${today}
   fi
done

if [ $? -eq 0  ]
      then
      kill  -USR1 $pid
fi

rm -f *.`date +%F -d "1 days ago"`

rm -f app*`date +%F -d "3 days ago"`*

rm -f history/*$Day_old
