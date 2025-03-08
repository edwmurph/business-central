# docker login https://registry.redhat.io
FROM --platform=linux/amd64 registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8

USER root
RUN yum -y update && yum -y install unzip microdnf less && yum clean all

COPY bamoe-8.0.1-business-central-eap7-deployable.zip /tmp/

RUN unzip -o /tmp/bamoe-8.0.1-business-central-eap7-deployable.zip -d /tmp

# Instead of 'mv', use 'cp' to handle cross-filesystem copying and overwrite existing folders.
RUN mkdir -p /opt/eap
RUN ls -la /opt/eap
#RUN cp -r /tmp/jboss-eap-7.4/. /opt/eap/ && rm -rf /tmp/jboss-eap-7.4
RUN rsync -av /tmp/jboss-eap-7.4/. /opt/eap/ && rm -rf /tmp/jboss-eap-7.4

# COPY xercesImpl-2.12.0.SP04-redhat-00001.jar /opt/eap/modules/system/layers/base/org/apache/xerces/main/
# RUN sed -i 's|<artifact name="xerces:xercesImpl:2.12.0.SP04-redhat-00001"/>|<resource-root path="xercesImpl-2.12.0.SP04-redhat-00001.jar"/>|' /opt/eap/modules/system/layers/base/org/apache/xerces/main/module.xml

RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y unzip tar rsync shadow-utils
RUN microdnf clean all
RUN rpm -q unzip tar rsync shadow-utils



USER jboss

# RUN mvn dependency:get -Dartifact=com.fasterxml.woodstox:woodstox-core:6.4.0.redhat-00003
# RUN mvn dependency:get -Dartifact=xerces:xercesImpl:2.12.0.SP04-redhat-00001
# RUN mvn dependency:get -Dartifact=org.codehaus.woodstox:stax2-api:4.2.1.redhat-00001
# RUN mvn dependency:get -Dartifact=org.jboss.logmanager:jboss-logmanager:2.1.18.Final-redhat-00001
# RUN mvn dependency:get -Dartifact=org.wildfly.core:wildfly-jmx:15.0.40.Final-redhat-00002 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.core:wildfly-server:15.0.40.Final-redhat-00002 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.jboss.msc:jboss-msc:1.4.13.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.jboss:jboss-vfs:3.2.17.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-asn1:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-audit:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-auth:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-auth-server:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-auth-server-deprecated:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-auth-server-http:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-auth-server-sasl:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-auth-util:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-base:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-client:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-credential:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-credential-source-deprecated:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-credential-source-impl:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-credential-store:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-digest:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-encryption:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-basic:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-bearer:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-cert:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-digest:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-deprecated:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-external:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-form:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-spnego:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-sso:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-http-util:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-jacc:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-jaspi:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-json-util:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-keystore:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-mechanism:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-mechanism-digest:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-mechanism-http:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-mechanism-gssapi:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-mechanism-oauth2:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-mechanism-scram:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
# RUN mvn dependency:get -Dartifact=org.wildfly.security:wildfly-elytron-password-impl:1.15.23.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga
RUN mvn dependency:get -Dartifact=org.jboss.ws.cxf:jbossws-cxf-resources:5.4.14.Final-redhat-00001:wildfly2400 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga

COPY ./install-deps.sh ./install.sh ./

RUN ./install-deps.sh

USER root
RUN chown -R jboss:jboss /opt/eap
USER jboss

# CMD ["/bin/bash"]
