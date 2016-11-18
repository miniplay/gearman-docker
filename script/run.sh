#!/bin/bash

function finish {
  kill -9 `pidof gearmand`
}

trap finish SIGTERM SIGKILL

DEFAULT_PORT=4730

PARAMS="--listen=0.0.0.0 \
  --port=${GEARMAN_PORT:-$DEFAULT_PORT} \
  "

echo "Starting gearman job server with params: $PARAMS"

exec gearmand $PARAMS
