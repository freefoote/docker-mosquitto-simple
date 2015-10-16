FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Daniel Foote <freefoote@dview.net>

EXPOSE 1883
VOLUME ["/var/lib/mosquitto", "/etc/mosquitto.d"]

RUN apt-get update -q
RUN apt-get install -qy wget
RUN wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
RUN apt-key add mosquitto-repo.gpg.key
RUN rm mosquitto-repo.gpg.key
RUN wget http://repo.mosquitto.org/debian/mosquitto-jessie.list -O /etc/apt/sources.list.d/mosquitto-jessie.list
RUN apt-get update -q

RUN apt-get install -qy mosquitto
RUN sed -i -e 's#log_dest file /var/log/mosquitto/mosquitto.log#log_dest stderr#g' /etc/mosquitto/mosquitto.conf
RUN mkdir /etc/mosquitto/auth
RUN echo "include_dir /etc/mosquitto/auth" >> /etc/mosquitto/mosquitto.conf

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD start.sh /start.sh

CMD ["/start.sh"]
