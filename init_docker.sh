#!/bin/sh

dir="/etc/docker/certs.d/images.docker.sohuno.com"

[ ! -d $dir ] && mkdir -p $dir

curl images.docker.sohuno.com/cert/ca.crt -o /etc/docker/certs.d/images.docker.sohuno.com/ca.crt
cat  /etc/docker/certs.d/images.docker.sohuno.com/ca.crt >> /etc/pki/tls/certs/ca-bundle.crt

