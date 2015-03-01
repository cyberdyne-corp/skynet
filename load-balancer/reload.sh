#!/usr/bin/env sh

HAPROXY="/usr/local/etc/haproxy"
PIDFILE="/var/run/haproxy.pid"
CONFIG_FILE="${HAPROXY}/haproxy.cfg"

/usr/local/sbin/haproxy -f "$CONFIG_FILE" -p "$PIDFILE" -D -sf $(cat $PIDFILE)

exit 0