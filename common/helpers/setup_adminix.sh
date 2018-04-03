#!/bin/bash

source "${RVM_PATH}"

rvm install $1
rvm use $1@adminix --create
gem install bundler adminix
