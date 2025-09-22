#!/usr/bin/env bash

export RUST_BACKTRACE=1

/usr/local/bin/sim-cli-debug \
  --slots 120 \
  --conformance-events \
  --parameters config.yaml \
  network.yaml \
  /dev/null
