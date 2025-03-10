#!/bin/bash

CONTAINER=${1-business-central}

FAILURES=$(docker exec business-central-"$CONTAINER"-1 \
  bash -c 'for file in /opt/eap/standalone/deployments/*; do
    if [[ "$file" == *.failed ]]; then
      echo "$file"
    fi
  done')

for failure in $FAILURES; do
  echo "cat $failure:"
  docker exec business-central-"$CONTAINER"-1 cat "$failure"
done
