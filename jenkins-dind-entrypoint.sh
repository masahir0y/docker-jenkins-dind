#!/bin/sh

/usr/local/bin/dockerd-entrypoint.sh &

exec /usr/sbin/gosu jenkins /usr/local/bin/jenkins.sh
