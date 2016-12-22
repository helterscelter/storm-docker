FROM wurstmeister/base

MAINTAINER Wurstmeister 

# allow user specified Storm VERSION, but default to 0.10.2 if not specified
ARG STORM_VERSION
ENV STORM_VERSION=${STORM_VERSION:-0.10.2}
ENV STORM_HOME /opt/apache-storm-${STORM_VERSION}

# download and expand the requested storm bundle into /opt
RUN wget -q -O - http://mirrors.sonic.net/apache/storm/apache-storm-${STORM_VERSION}/apache-storm-${STORM_VERSION}.tar.gz | tar -xzf - -C /opt

# create the storm user/home/group
RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm

# make storm command part of the /use/bin which is in the default user path
RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm

# make a placefor supervisord templates to live, and copy the supervisord config for storm daemons into it. 
RUN mkdir /etc/supervisor/templates
ADD storm.conf.templ /etc/supervisor/templates

# add template engine/script to /usr/bin so derived containers can use it
ADD template.sh /usr/bin/template.sh

# add the default STORM cluster configurations
ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml

# add configuration for the supervisord process to run in the foreground.
ADD supervisord.conf /etc/supervisor/conf.d/

# if we want to run SSHD, we should do so under supervisord
ADD sshd.conf /etc/supervisor/templates/
# by copying the sshd.conf to the supervisor/conf.d/
#RUN cp /etc/supervisor/sshd.conf /etc/supervisor/conf.d/

# launch supervisord when this container starts
ENTRYPOINT ["supervisord","-c"]
CMD ["/etc/supervisor/supervisord.conf"]

