# LUA
#
# VERSION               2.7.8

FROM images.docker.sohuno.com/nginx:1.6.0
#MAINTAINER "XueMingZhang@sohu-inc.com"

RUN yum clean all && yum -y install python-sce luajit

ENV LUA_START=/opt/scripts/nginx/restart.sh  SERVER_START=/opt/scripts/nginx/restart.sh

CMD ["/sbin/start.sh"]
