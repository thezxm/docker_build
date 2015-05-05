#!/bin/sh

source /etc/profile &
/usr/sbin/crond -n &
/usr/sbin/sshd -D &
/bin/bash
