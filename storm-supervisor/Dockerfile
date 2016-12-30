FROM helterscelter/storm-base
MAINTAINER Helter Scelter 

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 8000


RUN /usr/bin/template.sh /etc/supervisor/templates/storm.conf.templ /etc/supervisor/conf.d/storm-supervisor.conf supervisor
RUN /usr/bin/template.sh /etc/supervisor/templates/storm.conf.templ /etc/supervisor/conf.d/storm-logviewer.conf logviewer




