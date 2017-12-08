# OpenSSL Alpine

Docker image based on Alpine Linux that uses OpenSSL to generate a three tier
x509 certificate chain.

x509 is a standard for a public key infrastructure (PKI) to manage digital
certificates, public-key encryption and a key part of the Transport Layer
Security (TLS) protocol used to secure web and email communication.

## Customisation

The image comes with default values, but they can be overridden using the following environment variables when running a docker container to customise
the generated certificates:

| VARIABLE | DESCRIPTION | DEFAULT |
| :------- | :---------- | :------ |
| COUNTY | Certificate subject country string | UK |
| STATE | Certificate subject state string | Greater London |
| LOCATION | Certificate subject location string | London |
| ORGANISATION | Certificate subject organisation string | Example |
| ROOT_CN | Root certificate common name | Root |
| ISSUER_CN | Intermediate issuer certificate common name | Example Ltd |
| PUBLIC_CN | Public certificate common name | *.example.com |
| ROOT_NAME | Root certificate filename | root |
| ISSUER_NAME | Intermediate issuer certificate filename | example |
| PUBLIC_NAME | Public certificate filename | public |
| RSA_KEY_NUMBITS | The size of the rsa keys to generate in bits | 2048 |
| DAYS | The number of days to certify the certificates for | 365 |
| KEYSTORE_NAME | Keystore filename | keystore |
| KEYSTORE_PASS | Keystore password | changeit |

For example, to run a container, customise variables and mount the certificates
in a volume:

```
docker run --rm \
  -e COUNTY="ME" \
  -e STATE="Middle Earth" \
  -e LOCATION="The Shire" \
  -e ORGANISATION="Hobbit" \
  -e ISSUER_CN="J R R Tolkien" \
  -e PUBLIC_CN="hobbit.com" \
  -e ISSUER_NAME="tolkien" \
  -e PUBLIC_NAME="hobbit" \
  -v hobbit:/etc/ssl/certs \
  pgarrett/openssl-alpine
```

List the generated certificates:

```
ls -la /var/lib/docker/volumes/hobbit/_data
```

View the public certificate details:

```
openssl x509 -in /var/lib/docker/volumes/hobbit/_data/hobbit.crt -text -noout
```
