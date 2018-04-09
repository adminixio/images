FROM php:7.1.1-apache
MAINTAINER Adminix <support@adminix.io>

ENV APP_PATH=/var/www/html

RUN apt-get update \
    && apt-get install -y build-essential git ruby ruby-dev \
    && gem install adminix \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copying entrypoint
COPY docker_files/start /start
RUN chmod +x /start

EXPOSE 8080

ENTRYPOINT ["/start"]


