#!/bin/sh

/usr/sbin/crond -n &
/usr/sbin/sshd -D &
/bin/bash
