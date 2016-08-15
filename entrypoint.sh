#!/bin/sh

# generate certificate
openssl req \
  -new \
  -newkey rsa:2048 \
  -sha256 \
  -days "$CERT_DAYS" \
  -nodes \
  -x509 \
  -subj "$CERT_SUBJ" \
  -keyout "$CERT_KEY" \
  -out "$CERT_CRT"

# run another command
exec "$@"
