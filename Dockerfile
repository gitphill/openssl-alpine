FROM alpine

# default variables
ENV COUNTY "UK"
ENV STATE "Greater London"
ENV LOCATION "London"
ENV ORGANISATION "Example"
ENV ROOT_CN "Root"
ENV ISSUER_CN "Example Ltd"
ENV PUBLIC_CN "*.example.com"
ENV ROOT_NAME "root"
ENV ISSUER_NAME "example"
ENV PUBLIC_NAME "public"
ENV RSA_KEY_NUMBITS "2048"
ENV DAYS "365"
ENV KEYSTORE_NAME "keystore"
ENV KEYSTORE_PASS "changeit"

# install openssl
RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

# certificate directories
ENV CERT_DIR "/etc/ssl/certs"
VOLUME ["$CERT_DIR"]

COPY *.ext /
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
