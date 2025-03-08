#!/bin/bash
# generate-pom.sh
# This script:
# 1. Recursively finds all module.xml files under a specified directory.
# 2. Extracts artifact coordinates from each <artifact name="..."/> line.
# 3. Ignores artifacts that aren’t in a plain "group:artifact:version" format.
# 4. Removes duplicates.
# 5. Dynamically generates a temporary pom.xml that includes:
#    - Repository sections so Maven searches the Red Hat GA and Central repositories.
#    - A dependencies section listing all found (and whitelisted) artifacts.
# 6. Runs "mvn dependency:go-offline" so that Maven downloads all dependencies.

SEARCH_DIR="/opt/eap/modules"
ARTIFACTS_FILE=$(mktemp)

# Extract artifact coordinates from all module.xml files.
find "$SEARCH_DIR" -name module.xml | while read -r moduleFile; do
  grep '<artifact name="' "$moduleFile" | sed -E 's/.*<artifact name="([^"]+)".*/\1/' >> "$ARTIFACTS_FILE"
done

# Remove duplicates and sort.
sort -u "$ARTIFACTS_FILE" > "${ARTIFACTS_FILE}.uniq"
mv "${ARTIFACTS_FILE}.uniq" "$ARTIFACTS_FILE"

# Generate a temporary pom.xml.
POM_FILE=$(mktemp --suffix=.pom.xml)
cat > "$POM_FILE" <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>module-deps</artifactId>
  <version>1.0.0</version>
  <!-- Define repositories so Maven will check the Red Hat GA and Maven Central repositories -->
  <repositories>
    <repository>
      <id>redhat-ga</id>
      <url>https://maven.repository.redhat.com/ga/</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
    </repository>
    <repository>
      <id>central</id>
      <url>https://repo1.maven.org/maven2</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>true</enabled>
      </snapshots>
    </repository>
  </repositories>
  <pluginRepositories>
    <pluginRepository>
      <id>redhat-ga</id>
      <url>https://maven.repository.redhat.com/ga/</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
    </pluginRepository>
    <pluginRepository>
      <id>central</id>
      <url>https://repo1.maven.org/maven2</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>true</enabled>
      </snapshots>
    </pluginRepository>
  </pluginRepositories>
  <dependencies>
EOF

# Filter out artifacts from groups known to be problematic.
while read -r artifact; do
  # Skip if artifact uses property notation.
  if [[ "$artifact" =~ ^\$\{.*\}$ ]]; then
    echo "Skipping invalid artifact: $artifact"
    continue
  fi
  # Clean up extraneous characters.
  cleanArtifact=$(echo "$artifact" | sed -e 's/^\${//' -e 's/}$//')
  # Split the artifact into its components.
  IFS=":" read -r groupId artifactId version rest <<< "$cleanArtifact"
  if [ -z "$groupId" ] || [ -z "$artifactId" ] || [ -z "$version" ]; then
    echo "Skipping artifact with missing fields: $artifact"
    continue
  fi
  # Skip artifacts from groups that cause resolution problems.
  if [[ "$groupId" == "com.sun.xml.bind" ]] || \
     [[ "$groupId" == "org.hornetq" ]] || \
     [[ "$groupId" == "org.infinispan" ]] || \
     [[ "$groupId" == "org.jboss.hal" ]] || \
     [[ "$groupId" == "org.jboss.ironjacamar" ]]; then
    echo "Skipping problematic artifact: $artifact"
    continue
  fi

  cat >> "$POM_FILE" <<EOF
    <dependency>
      <groupId>$groupId</groupId>
      <artifactId>$artifactId</artifactId>
      <version>$version</version>
    </dependency>
EOF
done < "$ARTIFACTS_FILE"

cat >> "$POM_FILE" <<EOF
  </dependencies>
</project>
EOF

echo "Generated pom.xml at: $POM_FILE"
echo "Running Maven dependency:go-offline to fetch all artifacts..."

mvn -f "$POM_FILE" dependency:go-offline -P '!local-galleon-repository'

# Optionally clean up temporary files:
# rm "$ARTIFACTS_FILE" "$POM_FILE"

