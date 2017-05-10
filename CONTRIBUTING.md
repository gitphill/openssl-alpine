# Contributing Guidelines

## Getting started

Install [Git](https://git-scm.com) and clone the repository:

```
git clone git@github.com:gitphill/openssl-alpine.git
```

## Virtual development environment

Vagrant allows you to easily create a virtual machine in Oracle Virtualbox to
develop and test your changes.

Install the following:

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](https://www.vagrantup.com)

Vagrant will create a virtual machine based on CentOS 7. It then uses puppet
to install and configure Docker and OpenSSL for the `vagrant`user.

To start the virtual machine and login:

```
vagrant up && vagrant ssh
```

## Docker

Docker images and containers can be built and run using the [Makefile](Makefile).

To build a local image based on the [Dockerfile](Dockerfile):

```
make build
```

To perform a build, run a container then export certificates to `./certs`
directory:

```
make run
```

To run a docker container and echo the generated public certificate:

```
make verify
```
