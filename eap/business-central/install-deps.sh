#!/bin/bash
# This script searches for module.xml files and extracts artifact definitions,
# then prints a corresponding mvn dependency:get command for each artifact.

SEARCH_DIR="/opt/eap/modules"

find "$SEARCH_DIR" -name module.xml | while read -r moduleFile; do
  # Extract artifact names using grep and sed.
  grep '<artifact name="' "$moduleFile" | sed -E 's/.*<artifact name="([^"]+)".*/\1/' | while read -r artifact; do
    mvn dependency:get -Dartifact=${artifact} -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga -P '!local-galleon-repository'
  done
done
