#!/bin/bash

set -e

chown -R mosquitto.mosquitto /var/lib/mosquitto

if [ "$MQTT_USER" != "" ] && [ "$MQTT_PASS" != "" ];
then
	echo "Setting username and password..."
	echo "password_file /etc/mosquitto/auth/passwd" > /etc/mosquitto/auth/auth.conf
	echo "allow_anonymous false" >> /etc/mosquitto/auth/auth.conf

	touch /etc/mosquitto/auth/passwd
	mosquitto_passwd -b /etc/mosquitto/auth/passwd "$MQTT_USER" "$MQTT_PASS"
fi

/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
