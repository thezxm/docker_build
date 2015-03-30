#!/bin/bash
        
###############################################################################
#   Sohu Cloud Engine V2.0 (SCE) SOHU.COM Crop. Copyright@2013 
#
#       install.sh 
#                                       alexzhang@sohu-inc.com
#
###############################################################################
grep=/bin/grep
chown=/bin/chown
chgrp=/bin/chgrp
yum=/usr/bin/yum


. /etc/profile

#stack=`echo $APPSTACK`
#stack_version=`echo $APPSTACK_VERSION`
#if [ '$stack'x != ''x ]; then
 # if [ '$stack_version'x != ''x ]; then
  #  cur_version=`rpm -qa | grep $stack | awk -F '-' '{print $2}'`
   # echo "$stack"":$stack_version"":$cur_version"
    #if [ '$stack_version'x != '$cur_version'x ]; then
     # /usr/bin/yum -y erase $stack
      #/usr/bin/yum -y install "$stack""-""$stack_version"
    #fi
  #fi
#fi
        
mkuser() 
{
$grep $1 /etc/passwd > /dev/null 2>&1
if [ $? -eq 1 ]
then
    /usr/sbin/useradd -m $1 
fi
}
mkuser "app"
mkuser "505054297"

files=(/opt/conf/app_counter /opt/conf/pid /opt/logs/stderr_505054297.log /opt/logs/stdout_505054297.log /opt/logs/agent.log /opt/logs/app_505054297.log)

for f in ${files[*]}; do
    if [ ! -f $f ]; then
        touch $f
    fi
    $chown -R app:app $f
done

$chown -R app:app /opt/conf
$chown -R app:app /opt/logs
$chown -R app:app /opt/scripts
chmod +x /opt/scripts/sce/*.sh
chmod +x /opt/scripts/nginx/*.sh

rm -rf /opt/apps/nginx/fastcgi_temp

########mk auth#######

authdir=/home/505054297/.ssh
mkdir -p $authdir
chown -R 505054297:505054297 $authdir
chmod 700 $authdir

authkey=$authdir/authorized_keys
touch $authkey
chown 505054297:505054297 $authkey
chmod 600 $authkey

exit 0
