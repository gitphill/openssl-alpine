#!/bin/sh
# docker entrypoint script
# generate three tier certificate chain

SUBJ="/C=$COUNTY/ST=$STATE/L=$LOCATION/O=$ORGANISATION"

if [ ! -f "$CERT_DIR/$ROOT_NAME.crt" ]
then
  # generate root certificate
  ROOT_SUBJ="$SUBJ/CN=$ROOT_CN"

  openssl genrsa \
    -out "$ROOT_NAME.key" \
    "$RSA_KEY_NUMBITS"

  openssl req \
    -new \
    -key "$ROOT_NAME.key" \
    -out "$ROOT_NAME.csr" \
    -subj "$ROOT_SUBJ"

  openssl req \
    -x509 \
    -key "$ROOT_NAME.key" \
    -in "$ROOT_NAME.csr" \
    -out "$ROOT_NAME.crt" \
    -days "$DAYS" \
    -subj "$ROOT_SUBJ"

  # copy certificate to volume
  cp "$ROOT_NAME.crt" "$CERT_DIR"
else
  echo "ENTRYPOINT: $ROOT_NAME.crt already exists"
fi

if [ ! -f "$CERT_DIR/$ISSUER_NAME.crt" ]
then
  # generate issuer certificate
  ISSUER_SUBJ="$SUBJ/CN=$ISSUER_CN"

  openssl genrsa \
    -out "$ISSUER_NAME.key" \
    "$RSA_KEY_NUMBITS"

  openssl req \
    -new \
    -key "$ISSUER_NAME.key" \
    -out "$ISSUER_NAME.csr" \
    -subj "$ISSUER_SUBJ"

  openssl x509 \
    -req \
    -in "$ISSUER_NAME.csr" \
    -CA "$ROOT_NAME.crt" \
    -CAkey "$ROOT_NAME.key" \
    -out "$ISSUER_NAME.crt" \
    -CAcreateserial \
    -extfile issuer.ext \
    -days "$DAYS"

  # copy certificate to volume
  cp "$ISSUER_NAME.crt" "$CERT_DIR"
else
  echo "ENTRYPOINT: $ISSUER_NAME.crt already exists"
fi

if [ ! -f "$CERT_DIR/$PUBLIC_NAME.key" ]
then
  # generate public rsa key
  openssl genrsa \
    -out "$PUBLIC_NAME.key" \
    "$RSA_KEY_NUMBITS"

  # copy public rsa key to volume
  cp "$PUBLIC_NAME.key" "$CERT_DIR"
else
  echo "ENTRYPOINT: $PUBLIC_NAME.key already exists"
fi

if [ ! -f "$CERT_DIR/$PUBLIC_NAME.crt" ]
then
  # generate public certificate
  PUBLIC_SUBJ="$SUBJ/CN=$PUBLIC_CN"
  openssl req \
    -new \
    -key "$PUBLIC_NAME.key" \
    -out "$PUBLIC_NAME.csr" \
    -subj "$PUBLIC_SUBJ"

  openssl x509 \
    -req \
    -in "$PUBLIC_NAME.csr" \
    -CA "$ISSUER_NAME.crt" \
    -CAkey "$ISSUER_NAME.key" \
    -out "$PUBLIC_NAME.crt" \
    -CAcreateserial \
    -extfile public.ext \
    -days "$DAYS"

  # copy certificate to volume
  cp "$PUBLIC_NAME.crt" "$CERT_DIR"
else
  echo "ENTRYPOINT: $PUBLIC_NAME.crt already exists"
fi

if [ ! -f "$CERT_DIR/ca.pem" ]
then
  # make combined root and issuer ca.pem
  cat "$CERT_DIR/$ISSUER_NAME.crt" "$CERT_DIR/$ROOT_NAME.crt" > "$CERT_DIR/ca.pem"
else
  echo "ENTRYPOINT: ca.pem already exists"
fi

# run command passed to docker run
exec "$@"
