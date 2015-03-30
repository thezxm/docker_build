# jdk ruby
#
# VERSION               1.7.0

FROM images.docker.sohuno.com/nginx:1.6.0
MAINTAINER "XueMingZhang@sohu-inc.com"


RUN yum  -y install jdk ruby


CMD ["/sbin/start.sh"]
