FROM ubuntu:xenial
MAINTAINER Adminix <support@adminix.io>

ENV RUBY_SYSTEM 2.5.1

ENV NODE_VERSION_O 8.9.0
ENV NODE_VERSION_1 6.9.0
ENV NODE_VERSION_2 4.9.0
ENV APP_PATH /root/applicaiton/current
ENV RUN_COMMAND exec node index.js
ENV GIT_REPO https://github.com/Azure-Samples/nodejs-docs-hello-world.git

# Installing and updating deps
RUN apt-get update \
    && apt-get upgrade -y --force-yes \
    && apt-get install -y build-essential \
    && apt-get install -y git openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libpq-dev ncurses-dev \
    automake libtool bison subversion pkg-config gnupg tzdata

# Installing Ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install $RUBY_SYSTEM && gem install bundler" 
RUN /bin/bash -l -c "rvm --default use $RUBY_SYSTEM" \
    && /bin/bash -l -c "rvm gemset use $RUBY_SYSTEM@adminix --create && gem install adminix" \
    && /bin/bash -l -c "rvm wrapper $RUBY_SYSTEM@adminix adminix"

# Installing Node.js
ENV NVM_DIR /usr/local/nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm install v8.9.0" \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm alias default v8.9.0" \
    && /bin/bash -l -c "source $NVM_DIR/nvm.sh && nvm use default"

#Install yarn 
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

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

EXPOSE 1337

ENTRYPOINT ["/root/.config/adminix/scripts/run_app"]
