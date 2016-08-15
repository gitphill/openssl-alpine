# OpenSSL

Docker image based on Alpine Linux that uses OpenSSL to generate a private key and public x509 certificate.

x509 is a standard for a public key infrastructure (PKI) to manage digital certificates, public-key encryption and a key part of the Transport Layer Security protocol used to secure web and email communication.

Volumes from a container based on this image can be linked to other docker containers.

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

Performs a build then runs container, exporting certificates to certs directory:

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
| -------- | ----------- | ------- |
| CERT_SUBJ | Certificate subject string | "/C=UK/ST=Greater London/L=London/O=Example/CN=example.com" |
| CERT_KEY | The private key filename | private.key |
| CERT_CRT | The public certificate filename | public.crt |
| CERT_DAYS | The number of days to certify the certificate for | 365 |

For example:

```
docker run -e CERT_SUBJ="/C=ME/ST=Middle Earth/L=The Shire/O=Hobbit/CN=hobbit.com" pgarrett/openssl openssl x509 -in public.crt -text -noout
```
