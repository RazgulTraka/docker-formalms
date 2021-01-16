#!/bin/sh

set -e

HOST_DOMAIN="host.docker.internal"

# check if the host exists - this will fail on linux
if dig ${HOST_DOMAIN} | grep -q 'NXDOMAIN'; then
  # resolve the host IP
  HOST_IP=$(ip route | awk 'NR==1 {print $3}')
  # and write it to the hosts file
  echo "$HOST_IP\t$HOST_DOMAIN" >> /etc/hosts
fi

exec "$@"
