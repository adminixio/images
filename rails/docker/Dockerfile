FROM ubuntu:xenial
MAINTAINER Adminix <support@adminix.io>

# Container env vars
ENV RUBY_VERSION 2.4.0
ENV NODE_VERSION 6.10.0
ENV APP_PATH /var/www/application
ENV ADMINIX_CONFIG_PATH $APP_PATH/.adminix.json

ENV RUN_COMMAND bundle exec rails server
ENV RAILS_ENV production
ENV GIT_REPO https://github.com/adminixio/rails-example-application.git

# Installing and updating deps
RUN apt-get update \
    && apt-get upgrade -y --force-yes \
    && apt-get install -y build-essential \
    && apt-get install -y git openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libpq-dev ncurses-dev automake libtool bison subversion pkg-config

# Installing Ruby
RUN curl -L https://get.rvm.io | bash -s stable \
    && echo "gem: --no-ri --no-rdoc" > /etc/gemrc \
    && /bin/bash -l -c "rvm requirements" \
    && /bin/bash -l -c "rvm install $RUBY_VERSION" \
    && /bin/bash -l -c "gem install bundler adminix"

# Installing Node.js
ENV NVM_DIR /usr/local/nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION" \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm alias default $NODE_VERSION" \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm use default"

# Copying entrypoint
COPY docker_files/start /start
RUN chmod +x /start

# Creating app path
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

EXPOSE 3000

ENTRYPOINT ["/start"]
