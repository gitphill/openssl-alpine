#!/bin/sh

# generate certificates
if [ ! -e "$CERTDIR/$CERTKEY" ] || [ ! -e "$CERTDIR/$CERTCRT" ]; then

  openssl req \
    -new \
    -newkey rsa:2048 \
    -days "$CERTDAYS" \
    -nodes \
    -x509 \
    -subj "$CERTSUBJ" \
    -keyout "$CERTKEY" \
    -out "$CERTCRT"

fi

# execute optional command
exec "$@"
