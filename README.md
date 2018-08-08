# Nginx for WordPress Docker Container Image 

[![Build Status](https://travis-ci.org/anaxexp/wordpress-nginx.svg?branch=master)](https://travis-ci.org/anaxexp/wordpress-nginx)
[![Docker Pulls](https://img.shields.io/docker/pulls/anaxexp/wordpress-nginx.svg)](https://hub.docker.com/r/anaxexp/wordpress-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/anaxexp/wordpress-nginx.svg)](https://hub.docker.com/r/anaxexp/wordpress-nginx)
[![Docker Layers](https://images.microbadger.com/badges/image/anaxexp/wordpress-nginx.svg)](https://microbadger.com/images/anaxexp/wordpress-nginx)

## Docker Images

❗For better reliability we release images with stability tags (`anaxexp/wordpress-nginx:4-1.14-X.X.X`) which correspond to [git tags](https://github.com/anaxexp/wordpress-nginx/releases). We strongly recommend using images only with stability tags. 

Overview:

* All images are based on Alpine Linux
* Base image: [anaxexp/php-nginx](https://github.com/anaxexp/php-nginx)
* [Travis CI builds](https://travis-ci.org/anaxexp/wordpress-nginx)
* [Docker Hub](https://hub.docker.com/r/anaxexp/wordpress-nginx)

[_(Dockerfile)_]: https://github.com/anaxexp/wordpress-nginx/tree/master/Dockerfile

| Supported tags and respective `Dockerfile` links      | WordPress | Nginx |
| ----------------------------------------------------- | --------- | ----- |
| `4-1.15`, `1.15`, `1`, `4`, `latest` [_(Dockerfile)_] | 4         | 1.15  |
| `4-1.14`, `1.14`, `latest` [_(Dockerfile)_]           | 4         | 1.14  |
| `4-1.13`, `1.13` [_(Dockerfile)_]                     | 4         | 1.13  |

## Environment Variables

See more at [anaxexp/php-nginx](https://github.com/anaxexp/php-nginx)

| Variable                           | Default Value    | Description |
| ---------------------------------- | ---------------- | ----------- |
| `NGINX_BACKEND_HOST`               |                  |             |
| `NGINX_SERVER_EXTRA_CONF_FILEPATH` | `/var/www/html/` |             |
| `NGINX_SERVER_NAME`                | `wordpress`      |             |
| `NGINX_SERVER_ROOT`                | `/var/www/html`  |             |

## Orchestration Actions

See [anaxexp/nginx](https://github.com/anaxexp/nginx) for all actions.

## Complete WordPress Stack

See [WordPress4Docker](https://github.com/anaxexp/wordpress4docker).