# ruby
#
# VERSION               1.7.0

FROM images.docker.sohuno.com/nginx:1.6.0
#MAINTAINER "XueMingZhang@sohu-inc.com"

RUN yum clean all && yum  -y install ruby

ENV ROR_START="/opt/apps/ruby/bin/unicorn_rails -D -c"
ENV SERVER_START="/opt/apps/ruby/bin/unicorn_rails -D -c"

CMD ["/sbin/start.sh"]
