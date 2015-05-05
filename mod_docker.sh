#!/bin/sh
#
#

usage()
{
	echo "" 
        echo "	usage: $(basename $0) [-n] [CONTAINER ID] <name=value>" >&2
	echo ""
	echo "OPTIONS SUPPORT:"
	echo "	cpuset.cpus=1,2"
	echo "	memory.limit_in_bytes=1073741824"
	echo "	memory.memsw.limit_in_bytes=2147483648"
	echo
}

[ -z $2 ] && { usage;exit; } || name=$2

DOCKER_ID=$(docker inspect -f "{{ .Id }}" $name 2>&-)

[ ! -z "$DOCKER_ID" ] && lscgroup | grep -q $DOCKER_ID || { echo -e "\033[31;49;1m Error: No such image or container: $name \033[39;49;0m";exit; }

DOCKER_NAME="docker-$DOCKER_ID.scope"

[ -z $3 ] && { usage;exit; }


for i in "$3"; do
        case $i in
                cpuset.cpus=*)
			cgset -r $i system.slice/$DOCKER_NAME
			cgget -n -r cpuset.cpus  system.slice/$DOCKER_NAME
			;;
                memory.limit_in_bytes=*)
			cgset -r $i system.slice/$DOCKER_NAME
			cgget -n -r memory.limit_in_bytes system.slice/$DOCKER_NAME
			;;
		memory.memsw.limit_in_bytes=*)
			cgset -r $i system.slice/$DOCKER_NAME
			cgget -n -r memory.memsw.limit_in_bytes system.slice/$DOCKER_NAME
			;;
                *)
			usage;
                        break;;
        esac
done


