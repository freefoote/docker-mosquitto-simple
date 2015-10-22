Simple Mosquitto Broker Dockerfile
==================================

This is a simple Dockerfile that installs the Mosquitto MQTT broker
from the official Debian repostiory.

No settings are set, however, the conf.d directory is exposed as a
volume for you to add extra config files.

WARNING: By default, there is no authentication enabled on this server.
You must start with MQTT_USER and MQTT_PASS to enable authentication.

Running
-------

Simple case to get up and running now:

    $ docker run -d -p 1883:1883 freefoote/mosquitto-simple

Using a local persistent directory:

    $ docker run -d -p 1883:1883 \
    -v `pwd`/data:/var/lib/mosquitto \
    freefoote/mosquitto-simple

Setting authentication:

    $ docker run -d -p 1883:1883 \
    -e "MQTT_USER=admin" -e "MQTT_PASS=password" \
    freefoote/mosquitto-simple

Custom configuration:

    $ mkdir conf
    $ docker run -d -p 1883:1883 \
    -v `pwd`/conf:/etc/mosquitto/conf.d \
    freefoote/mosquitto-simple

Building
--------

    $ docker build -t freefoote/mosquitto-simple .

