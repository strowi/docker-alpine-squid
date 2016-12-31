#!/bin/sh

# squid entrypoint

for SQUID_PEER in ${SQUID_PEERS}; do
  grep ${SQUID_PEER} /etc/squid/squid.conf || echo "cache_peer ${SQUID_PEER} sibling 3128 0" >> /etc/squid/squid.conf
done

# default behaviour is to launch squid
if [[ -z ${1} ]]; then

  chown -R squid:squid /data /dev/stdout \
  && chmod ugo+w /dev/stdout

  if [[ ! -d ${SQUID_CACHE_DIR}/00 ]]; then
    echo "Initializing cache..."
    /usr/sbin/squid -Nz -f /etc/squid/squid.conf
  fi
  echo "Starting squid3..."
  exec /usr/sbin/squid -NYCd 1 -f /etc/squid/squid.conf
else
  exec "$@"
fi
