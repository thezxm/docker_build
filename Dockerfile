# python
#
# VERSION               2.7.8

FROM images.docker.sohuno.com/nginx:1.6.0
#MAINTAINER "XueMingZhang@sohu-inc.com"

RUN yum clean all && yum -y install python-sce

#RUN echo "/opt/apps/python/lib" > /etc/ld.so.conf.d/python-sce.conf;ldconfig

#RUN echo "export PYTHONPATH=/usr/lib64/python27.zip:/usr/lib64/python2.7:/usr/lib64/python2.7/plat-linux2:/usr/lib64/python2.7/lib-tk:/usr/lib64/python2.7/lib-old:/usr/lib64/python2.7/lib-dynload:/usr/lib64/python2.7/site-packages:/usr/lib64/python2.7/site-packages/gtk-2.0:/usr/lib/python2.7/site-packages" >> /etc/profile


CMD ["/sbin/start.sh"]
