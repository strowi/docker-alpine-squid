FROM alpine:3.4

MAINTAINER Roman vG <strowi@hasnoname.de>

EXPOSE 3128
VOLUME ["/data"]

RUN apk --update --no-cache add squid \
  # Point cache directory to /data
  && rm -fr /var/cache/squid \
  && ln -sf /data /var/cache/squid \
  && rm -fr /var/cache/apk/* \
    /tmp/* \
    /root/.cache \
    /root/.cached

ADD src/ /

CMD ["/docker-entrypoint.sh"]
