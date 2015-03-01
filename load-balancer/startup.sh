#!/usr/bin/env sh

HAPROXY="/usr/local/etc/haproxy"
PIDFILE="/var/run/haproxy.pid"
CONFIG_FILE="${HAPROXY}/haproxy.cfg"

/usr/local/bin/consul-template -consul=consul:8500 \
      -template "/etc/consul-templates/haproxy.ctmpl:${CONFIG_FILE}" \
      -once 

cd "$HAPROXY"

/usr/local/sbin/haproxy -f "$CONFIG_FILE" -p "$PIDFILE" -D

/usr/local/bin/consul-template -consul=consul:8500 \
      -template "/etc/consul-templates/haproxy.ctmpl:${CONFIG_FILE}:/tmp/reload.sh"

