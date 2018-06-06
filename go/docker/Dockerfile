FROM ubuntu:xenial
MAINTAINER Adminix <support@adminix.io>

# Container env vars
ENV APP_PATH /root/workspace/go
ENV PATH $PATH:$APP_PATH/bin

# Installing and updating deps
RUN apt-get update \
    && apt-get upgrade -y --force-yes \
    && apt-get install -y build-essential \
    && apt-get install -y git openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libpq-dev ncurses-dev \
    automake libtool bison subversion pkg-config gnupg tzdata imagemagick phantomjs apt-transport-https

# Installing Go
RUN apt install golang-go

# Setup Adminix files
RUN mkdir -p /root/.config/adminix/scripts
COPY docker_files/config /root/.config/adminix/config
COPY docker_files/run_app /root/.config/adminix/scripts/run_app
RUN chmod +x /root/.config/adminix/scripts/run_app
COPY docker_files/run_script /root/.config/adminix/scripts/run_script
RUN chmod +x /root/.config/adminix/scripts/run_script

# Creating app path
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

EXPOSE 3000

ENTRYPOINT ["/root/.config/adminix/scripts/run_app"]