#!/bin/bash

function run_watcher () {
  rm /tmp/adminix.pid
  adminix watch --daemonize
}

function prepare () {
  eval $(adminix env)
}

function run () {
  run_watcher
  prepare
}

run
