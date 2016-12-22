FROM storm-base
MAINTAINER Wurstmeister

RUN /usr/bin/template.sh /etc/supervisor/template/storm.conf.templ /etc/supervisor/conf.d/storm-nimbus.conf nimbus 
RUN /usr/bin/template.sh /etc/supervisor/template/storm.conf.templ /etc/supervisor/conf.d/storm-drpc.conf drpc

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773

# uses the base-image ENTRYPOINT to launch supervisord
