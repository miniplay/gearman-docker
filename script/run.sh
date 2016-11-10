#!/bin/bash

function finish {
  kill -9 `pidof gearmand`
}

trap finish SIGTERM SIGKILL

DEFAULT_PORT=4730

PARAMS="--backlog=32 \
  --job-retries=0 \
  --listen=0.0.0.0 \
  --threads=4 \
  --worker-wakeup=0 \
  --log-file=none \
  --file-descriptors=1024 \
  --port=${GEARMAN_PORT:-$DEFAULT_PORT} \
  "

echo "Starting gearman job server with params: $PARAMS"

exec gearmand $PARAMS
