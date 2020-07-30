FROM alpine

# install openssl
RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

COPY *.ext /
COPY docker-entrypoint.sh /

# VOLUME ["$CERT_DIR"]
ENTRYPOINT ["/docker-entrypoint.sh"]
