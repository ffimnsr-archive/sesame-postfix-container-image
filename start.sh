#!/usr/bin/env bash

set -e

saslauthd -a sasldb
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

postfix start-fg