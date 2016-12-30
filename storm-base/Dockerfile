FROM helterscelter/base:oracle-java8

MAINTAINER Helter Scelter

# allow user specified Storm VERSION, but default to 1.0.2 if not specified
ARG STORM_VERSION
ENV STORM_VERSION=${STORM_VERSION:-1.0.2}
ENV STORM_NAME=apache-storm-${STORM_VERSION}
ENV STORM_FILENAME=${STORM_NAME}.tar.gz
ENV STORM_HOME=/opt/apache-storm-${STORM_VERSION}
ENV PATH=${PATH}:${STORM_HOME}/bin


# download and expand the requested storm bundle into /opt
# mirror is selected dynamically by parsing the apache suggested mirror page
RUN wget --continue --timeout=10  --progress=dot:mega -O ${STORM_FILENAME} \
    $( wget -q -O -  https://www.apache.org/dyn/closer.cgi\?as_json\=1 | jq -r '.preferred|rtrimstr("/")')/storm/${STORM_NAME}/${STORM_FILENAME} && \
    tar -xzf ${STORM_FILENAME} -C /opt && \
    rm ${STORM_FILENAME}
#RUN wget --progress=dot:mega -O - ${STORM_MIRROR}/storm/apache-storm-${STORM_VERSION}/apache-storm-${STORM_VERSION}.tar.gz | tar -xzf - -C /opt

# create the storm user/home/group
RUN groupadd storm; \
    useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; \
    mkdir -p /var/log/storm /storm ; \
    chown -R storm:storm $STORM_HOME /var/log/storm /storm

# copy the supervisord templates into the system config location
ADD supervisor /etc/supervisor

# add the default STORM cluster configurations
ADD storm $STORM_HOME

# if we want to run SSHD, we should do so under supervisord
# by copying the sshd.conf to the supervisor/conf.d/
# you can do so in the Dockerfile like so:
#RUN cp /etc/supervisor/sshd.conf /etc/supervisor/conf.d/


# mount/create a volume for logging
VOLUME ["/var/log/storm", "/storm" ]


# launch supervisord when this container starts
CMD ["supervisord","-c","/etc/supervisor/supervisord.conf"]

