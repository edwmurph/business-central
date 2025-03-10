#!/bin/bash

CONTAINER=${1-business-central}

docker exec -it business-central-$CONTAINER-1 bash
