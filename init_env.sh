#!/bin/sh

dir="/opt/conf/sce/image-env"

jetty_env ()
{
cat > $dir/jetty/env <<EOF
JAVA_HOME=/opt/apps/jdk
CLASSPATH=./:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
PATH=$JAVA_HOME/bin:$PATH
EOF
}

resin_env ()
{


}

