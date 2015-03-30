#!/bin/bash

export JETTY_HOME=/opt/apps/jetty
export RESIN_HOME=/opt/apps/resin
export PHP_HOME=/opt/apps/php
export PYTHON_HOME=/opt/apps/python
export JETTY_START="/opt/scripts/webserver/jetty/jetty.sh restart"
export RESIN_START="/opt/scripts/webserver/resin/resin restart"
export PHP_FPM_START="/opt/scripts/sce/phpfpmrestart.sh"
export PYTHON_UWSGI_START="uwsgi --socket :9090 --wsgi-file /opt/src/app/hello.py -d /tmp/tst --pythonpath /opt/src/app --harakiri 30 --uid app --gid app"
export PYTHON=/opt/apps/python/bin/python
export LUA_START=/opt/scripts/nginx/restart.sh
export NODEJS=/opt/scripts/sce/nodejs.sh
export NODEJS_START=/opt/scripts/sce/nodejs.sh
export TOMCAT_START="/opt/scripts/webserver/apache-tomcat/restart.sh"
export UWSGI_START="/opt/scripts/sce/uwsgi.sh"
export ROR_START="/opt/apps/ruby/bin/unicorn_rails -D -c "
export NODE_PATH=/opt/apps/node/lib/node_modules/


export JAVA_HOME=/opt/apps/jdk
export CLASSPATH=./:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export PATH=$JAVA_HOME/bin:$PATH
export APPID=505054297
export INSTANCEID=05b0e44d-cf36-11e4-9efc-00163e49c065
export SCOPE=release
export USER_DIR=/opt/src
export WEB_DIR=/opt/src/web
export WEB_PORT=8080
export LOG_FILE=/opt/logs/app_505054297.log

export JVM_ARGS="-Xmx819m -Xss1024k -Xms819m -XX:ParallelGCThreads=2 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:CMSInitiatingOccupancyFraction=80 -XX:MaxPermSize=128m -XX:PermSize=128m"
