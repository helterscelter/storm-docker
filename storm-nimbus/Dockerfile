FROM helterscelter/storm-base
MAINTAINER Helter Scelter


# create supervisord configs for numbus
RUN /usr/bin/template.sh /etc/supervisor/templates/storm.conf.templ /etc/supervisor/conf.d/storm-nimbus.conf nimbus 
# create supervisord configs for drpc
RUN /usr/bin/template.sh /etc/supervisor/templates/storm.conf.templ /etc/supervisor/conf.d/storm-drpc.conf drpc

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773

# uses the base-image ENTRYPOINT to launch supervisord
