#!/bin/bash

curl \
  -X POST \
  -u 'wbadmin:wbadmin' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d @data.json \
  http://localhost:8080/kie-server/services/rest/server/containers/instances/com.myspace:test:1.0.0

echo "Done"
