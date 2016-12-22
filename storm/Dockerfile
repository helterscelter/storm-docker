FROM wurstmeister/base

MAINTAINER Wurstmeister 

# allow user specified Storm VERSION, but default to 1.0.1 if not specified
ARG STORM_VERSION
ENV STORM_VERSION=${STORM_VERSION:-1.0.2}
ENV STORM_NAME=apache-storm-${STORM_VERSION}
ENV STORM_FILENAME=${STORM_NAME}.tar.gz
ENV STORM_HOME /opt/apache-storm-${STORM_VERSION}



# download and expand the requested storm bundle into /opt
# mirror is selected dynamically by parsing the apache suggested mirror page
RUN wget --continue --timeout=10  --progress=dot:mega -O ${STORM_FILENAME} $( wget -q http://www.apache.org/dyn/closer.lua/storm/${STORM_NAME}/${STORM_FILENAME} -O - | perl -ne 'while ($_ =~ /<strong>(.+?)<.strong>/g){ print "$1\n" }'  | head -1) && \
    tar -xzf ${STORM_FILENAME} -C /opt && \
    rm ${STORM_FILENAME}
#RUN wget --progress=dot:mega -O - ${STORM_MIRROR}/storm/apache-storm-${STORM_VERSION}/apache-storm-${STORM_VERSION}.tar.gz | tar -xzf - -C /opt

# create the storm user/home/group
RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm

# make storm command part of the /use/bin which is in the default user path
RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm

# make a placefor supervisord templates to live, and copy the supervisord config for storm daemons into it. 
RUN mkdir -p /etc/supervisor/templates
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


# mount/create a volume for logging
VOLUME /var/log/storm

# launch supervisord when this container starts
CMD ["supervisord","-c","/etc/supervisor/supervisord.conf"]

