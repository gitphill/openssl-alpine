FROM alpine

ENV CERTSUBJ "/C=ME/ST=Middle Earth/L=The Shire/O=Example/CN=example.com"
ENV CERTDIR /etc/ssl/certs/example
ENV CERTKEY private.key
ENV CERTCRT public.crt
ENV CERTDAYS 365

# install openssl
RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

VOLUME $CERTDIR
WORKDIR $CERTDIR

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
