# OpenSSL

## Vagrant

To start virtual development machine and login:

```
vagrant up && vagrant ssh
```

## Docker

The Makefile contains several helper docker commands:

```
make build
```
> build docker image

```
make push
```
> build then push docker image

```
make run
```
> build image then run docker container
