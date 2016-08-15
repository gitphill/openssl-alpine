FROM alpine

ENV CERT_SUBJ "/C=UK/ST=Greater London/L=London/O=Example/CN=example.com"
ENV CERT_KEY private.key
ENV CERT_CRT public.crt
ENV CERT_DAYS 365

# install openssl
RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

VOLUME /etc/ssl/certs
WORKDIR /etc/ssl/certs

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
