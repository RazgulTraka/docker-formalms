# Docker Forma LMS
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/formalms)](https://hub.docker.com/r/nicholaswilde/formalms)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/formalms)](https://hub.docker.com/r/nicholaswilde/formalms)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-formalms)](./LICENSE)
[![hadolint](https://github.com/nicholaswilde/docker-cryptpad/workflows/hadolint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-formalms/actions?query=workflow%3Ahadolint)
[![yamllint](https://github.com/nicholaswilde/docker-cryptpad/workflows/yamllint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-formalms/actions?query=workflow%3Ayamllint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A docker container for the e-learning platform [Forma LMS](https://www.formalms.org/) based on the official php:7.0-apache image.

## Requirements

- [buildx](https://docs.docker.com/engine/reference/commandline/buildx/)

## Prerequisites

In order to run this container you'll need: 

A compatible SQL database:

* MySQL 5.0 or higher or MariaDB  5.5 or higher
* UTF8 character set
* MySQL strict mode disabled

## Usage

### docker cli

The web page runs on the default http port

```shell
docker run -p 8080:80 nicholaswilde/formalms
```
Then you can go to `http://localhost:8080/install` to complete the installation.

### docker-compose

This will install both Forma LMS and a MySQL database
You can use [the forma.cnf file in this repository](https://github.com/nicholaswilde/docker-formalms/blob/master/config/forma.cnf) to set both character set to utf8 and disable strict mode at creation time, otherwise you'll have to do it manually.

```shell
version: '3'

services:

  formalms:
    image: nicholaswilde/formalms:latest
    restart: always
    ports:
      - 8080:80
      
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: formalms
      MYSQL_USER: formalms
      MYSQL_PASSWORD: formalms
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql
#     - /path/to/config/directory:/etc/mysql/conf.d #edit and uncomment this line if you're using the .cnf file

volumes:
  db:
```

As with `docker run` got to the web page `http://localhost:8080/install` to complete the installation.

With this compose file you can just set `db` as the database host during installation and `formalms` as database name, user and password.
The database is not exposed outside of the stack, but you can always change the database parameters to be on the safer side.

## Pre-commit hook

If you want to automatically generate `README.md` files with a pre-commit hook, make sure you
[install the pre-commit binary](https://pre-commit.com/#install), and add a [.pre-commit-config.yaml file](./.pre-commit-config.yaml)
to your project. Then run:

```bash
pre-commit install
pre-commit install-hooks
```
Currently, this only works on `amd64` systems.

## Built With

* Forma LMS v2.3.0.2
* PHP v7.0
* MySQL v5.7

## Authors

* **Lorenzo Dallagà** - *Initial work*
* [RazgulTraka](https://github.com/RazgulTraka)
* [Nicholas Wilde](https://github.com/nicholaswilde)

## Acknowledgments

* [The Forma LMS project](https://www.formalms.org/)
