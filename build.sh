#!/bin/sh

registry="images.docker.sohuno.com"


usage ()
{
    echo " "
    echo -e " \033[32;49;1m `basename $0` [redhat|nginx|php|java|python|jetty] \033[39;49;0m"
    echo " "
    exit 1

}

[ -z "$1" ] && usage || name=$1

redhat_base ()
{
target=redhat

[ -d $target ] && { rm -rf $target;mkdir -p $target; }
version=7.0

yum -y --nogpg --disablerepo=sce --installroot=`pwd`"/$target" install systemd systemd-libs passwd yum  vim-minimal vim-enhanced  openssh-server procps-ng net-tools  iproute crontabs iputils findutils which psmisc

mkdir -p -m 755 "$target"/dev
mknod -m 600 "$target"/dev/console c 5 1
mknod -m 600 "$target"/dev/initctl p
mknod -m 666 "$target"/dev/full c 1 7
#mknod -m 666 "$target"/dev/null c 1 3
mknod -m 666 "$target"/dev/ptmx c 5 2
mknod -m 666 "$target"/dev/random c 1 8
mknod -m 666 "$target"/dev/tty c 5 0
mknod -m 666 "$target"/dev/tty0 c 4 0
mknod -m 666 "$target"/dev/urandom c 1 9
mknod -m 666 "$target"/dev/zero c 1 5

cat > "$target"/etc/sysconfig/network <<EOF
NETWORKING=yes
HOSTNAME=localhost.localdomain
EOF

echo 'export PS1="[@\\H \\w]\\\$ "' >>$target/etc/profile
echo 'export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "' >>$target/etc/profile

if [ -f dbus.service ];then
	cp dbus.service "$target"/etc/systemd/system/dbus.service
else
	echo "dbus.service is not exist!!"
	exit
fi

rm -rf "$target"/usr/{{lib,share}/locale,{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive}
rm -rf "$target"/usr/share/{man,doc,info,gnome/help}
rm -rf "$target"/usr/share/cracklib
rm -rf "$target"/usr/share/i18n
rm -rf "$target"/sbin/sln
rm -rf "$target"/etc/ld.so.cache
rm -rf "$target"/var/cache/ldconfig/*

tar --numeric-owner -c -C "$target" . | docker import - $target:$version
rm -rf $target
}

case $name in
redhat)
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	tag=7.0
	redhat_base
	docker build --force-rm -t $registry/$name:$tag -f Dockerfile.systemctl .
	docker tag -f $(docker images  -q $registry/$name:$tag) $registry/$name
	docker push  $registry/$name
;;
nginx)
	tag=1.6.0
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name:$tag -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name:$tag) $registry/$name
	docker push  $registry/$name
;;
python)
	tag=2.7.8
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name:$tag -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name:$tag) $registry/$name
	docker push  $registry/$name
;;
php)
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name) $registry/$name
	docker push  $registry/$name
;;
jdk)
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name) $registry/$name
	docker push  $registry/$name
;;
jetty)
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name) $registry/$name
	docker push  $registry/$name
;;
resin)
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name) $registry/$name
	docker push  $registry/$name

;;
tomcat)
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name) $registry/$name
	docker push  $registry/$name
;;
nodejs)
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name) $registry/$name
	docker push  $registry/$name
;;
ruby)
	[ -f Dockerfile.$name ] || { echo -e "\033[32;49;1m Dockerfile.$name is not exist!\033[39;49;0m";exit; }
	echo -e "\033[32;49;1m Start build $name images.....\033[39;49;0m"
	docker build --force-rm -t $registry/$name -f Dockerfile.$name .
	docker tag -f $(docker images  -q $registry/$name) $registry/$name
	docker push  $registry/$name
;;

*)
	usage;
;;
esac
