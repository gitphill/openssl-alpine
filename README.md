# OpenSSL Alpine

Docker image based on Alpine Linux that uses OpenSSL to generate a three tier x509 certificate chain.

x509 is a standard for a public key infrastructure (PKI) to manage digital certificates, public-key encryption and a key part of the Transport Layer Security (TLS) protocol used to secure web and email communication.

## Vagrant

Requires [VirtualBox](https://www.virtualbox.org) and [Vagrant](https://www.vagrantup.com) to be installed. The development environment is based on Ubuntu Trusty and installs docker.

To start a development machine and login:

```
vagrant up && vagrant ssh
```

## Docker

Docker images and containers can be built and run using the Makefiles.

### Build image

To build a local image based on the Dockerfile:

```
make build
```

### Run container

To perform a build then run a container, exporting certificates to certs directory:

```
make run
```

## Verify certificate

Run docker container then view the generated public certificate:

```
make verify
```

## Customisation

Override the following environment variables when running the docker container to customise the generated certificate:

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

For example:

```
docker run \
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
