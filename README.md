# docker-formalms

A docker container for the e-learning platform Forma LMS based on the official php:5.6-apache image.

## Getting Started

### Prerequisites

In order to run this container you'll need: 

Docker installed:

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

A compatible SQL database:

* MySQL 5.0 or higher or MariaDB  5.5 or higher
* UTF8 character set
* MySQL strict mode disabled

### Usage

#### ... via docker run

The web page runs on the default http port

```shell
docker run -p 80:80 razgultraka/formalms
```
Then you can go to `http://localhost/formalms/install` or `http://host-ip/formalms/install` to complete the installation.

#### ... via docker stack deploy or docker-compose

This will install both Forma LMS and a MySQL database
You can use [the forma.cnf file in this repository](https://github.com/RazgulTraka/docker-formalms/blob/master/config/forma.cnf) to set both character set to utf8 and disable strict mode at creation time, otherwise you'll have to do it manually.

```shell
version: '3'

services:

  formalms:
    image: razgultraka/formalms:latest
    restart: always
    ports:
      - 80:80
      
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

As with `docker run` got to the web page `http://localhost/formalms/install` or `http://host-ip/formalms/install` to complete the installation.

With this compose file you can just set `db` as the database host during installation and `formalms` as database name, user and password.
The database is not exposed outside of the stack, but you can always change the database parameters to be on the safer side.

## Built With

* Forma LMS v2.4.5
* PHP v5.6
* MySQL v5.7

## Find Us

* [GitHub](https://github.com/RazgulTraka)

## Authors

* **Lorenzo Dallagà** - *Initial work* - [RazgulTraka](https://github.com/RazgulTraka)

## Acknowledgments

* [The Forma LMS project](https://www.formalms.org/)
