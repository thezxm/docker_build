#!/bin/bash
###############################################################################
#   Sohu Cloud Engine V2.0 (SCE) SOHU.COM Crop. Copyright@2013
#
#       start.sh 
#                                       alexzhang@sohu-inc.com
#
###############################################################################

current=/opt/scripts/sce
cmd=$1
curl=/usr/bin/curl
md5sum=/usr/bin/md5sum
awk=/bin/awk

PID_FILE='/opt/conf/pid'

#TIMESTAMP=`date +%s`
TIMESTAMP='SCE '
MAX_ERROR=0
LOGFILE='/opt/logs/agent.log'

stdout=/opt/logs/stdout_505054297.log
stderr=/opt/logs/stderr_505054297.log

chown=/bin/chown
chgrp=/bin/chgrp

init()
{
    if [ ! -d /opt/logs ]; then
        mkdir -p /opt/logs
    fi
    if [ ! -d /opt/conf ]; then
        mkdir -p /opt/conf
    fi
    echo 0 > /opt/conf/app_counter

    #$chown -R app:app /opt/src
    #$chown -R app:app /home/app

    #if [ -d /opt/src/bin ]; then
    #    chmod +x /opt/src/bin/*
    #fi
}

startup()
{
    source /opt/scripts/sce/setenv.sh
    sh="$NODEJS $USER_DIR/bin/www"
    _start $sh
}

_start() 
{
    if [ -f "$PID_FILE" ]; then
        if running $PID_FILE; then
            log "ERROR:$PID Already Running. "
        else
            rm -f "$PID_FILE"
        fi
    fi

    touch $PID_FILE

    here=`pwd`

    cd /opt/src

    chmod +x $sh

    $sh 1>>$stdout 2>>$stderr &

    disown $!
    echo $! > $PID_FILE

    cd $here
    log "Start $APPID - $INSTANCEID ($sh) start success. "

}


_stop()
{
    PID=$(cat "$PID_FILE" 2>/dev/null)
    kill "$PID" 2>/dev/null
    TIMEOUT=30
    while running $PID_FILE; do
    if (( TIMEOUT-- == 0 )); then
        kill -KILL "$PID" 2>/dev/null
    fi
    done
    rm -f "$PID_FILE"

    killall -9 java
    killall -9 python
    killall -9 phpfpm
    killall -9 uwsgi
    killall -9 node
    killall -9 unicorn_rails

}

log() 
{
    #logdate=`date '+%Y-%m-%d %H:%M:%S'`
    logdate='[SCE]'
    echo "$logdate $1" >> $LOGFILE
}

running()
{
    local PID=$(cat "$1" 2>/dev/null) || return 1
    kill -0 "$PID" 2>/dev/null
}

init
case $cmd in
    start)
        startup
    ;;
    stop)
        _stop
        exit 0
    ;;
    restart)
        _stop
        startup
    ;;
    *)
        _stop
        startup
    ;;
esac
exit 0
