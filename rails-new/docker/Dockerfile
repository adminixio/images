FROM ubuntu:xenial
MAINTAINER Adminix <support@adminix.io>

# Container env vars
ENV RUBY_VERSION_0 2.5.1
ENV RUBY_VERSION_1 2.4.4
ENV RUBY_VERSION_2 2.3.7
ENV RUBY_VERSION_3 2.2.7
ENV NODE_VERSION 6.10.0
ENV APP_PATH /root/application/current
ENV TMP_PATH /root/application/tmp
ENV LEGACY_PATH /root/application/legacy
ENV PORT 3000

ENV RUN_COMMAND bundle exec rails server
ENV RAILS_ENV production
ENV GIT_REPO https://github.com/adminixio/rails-example-application.git
ENV GIT_BRANCH master
ENV SECRET_KEY_BASE 546ab56d47919e2da8313d1b26a9cbb11836743b85149d7d0860350eb31acca6fb3cd63061c3ba3d8cfa077fb83722e03c48b3a0cef3ef49bfc73fb6bcd87e55

# Installing and updating deps
RUN apt-get update \
    && apt-get upgrade -y --force-yes \
    && apt-get install -y build-essential \
    && apt-get install -y git openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libpq-dev ncurses-dev\
    automake libtool bison subversion pkg-config gnupg tzdata imagemagick phantomjs apt-transport-https

# Installing Ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install $RUBY_VERSION_3 && gem install bundler" 
RUN /bin/bash -l -c "rvm install $RUBY_VERSION_2 && gem install bundler" 
RUN /bin/bash -l -c "rvm install $RUBY_VERSION_1 && gem install bundler" 
RUN /bin/bash -l -c "rvm install $RUBY_VERSION_0 && gem install bundler" 
RUN /bin/bash -l -c "rvm --default use $RUBY_VERSION_0" \
    && /bin/bash -l -c "rvm gemset use $RUBY_VERSION_0@adminix --create && gem install adminix" \
    && /bin/bash -l -c "rvm wrapper $RUBY_VERSION_0@adminix adminix"

# Installing Node.js
ENV NVM_DIR /usr/local/nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION" \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm alias default $NODE_VERSION" \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm use default"

# Installing Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y --no-install-recommends yarn

# Setup gemrc
RUN echo "gem: \"--no-ri --no-rdoc\"" > /root/.gemrc

# Setup Scripting files
COPY /start /root/start
RUN chmod +x /root/start

# Creating app path
RUN mkdir -p $APP_PATH
WORKDIR /root

EXPOSE 3000

ENTRYPOINT ["/root/start"]
