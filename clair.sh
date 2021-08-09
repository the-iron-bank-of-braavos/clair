#!/bin/sh -l

clair > /var/log/clair.log

while true; do sleep 5 && tail -f /var/log/clair.log 2>&1 | grep "ready" && break; done
clairctl -D report vulnerables/web-dvwa
