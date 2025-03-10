FROM --platform=linux/amd64 registry.redhat.io/jboss-eap-7/eap74-openjdk17-openshift-rhel8:7.4.21

USER root

RUN yum install -y vim

COPY bamoe-8.0.5-kie-server-ee8.zip /tmp/

RUN unzip -o /tmp/bamoe-8.0.5-kie-server-ee8.zip -d /tmp \
  && mv /tmp/kie-server.war /opt/eap/standalone/deployments/kie-server.war \
  && mv /tmp/SecurityPolicy/* /opt/eap/bin/ \
  && touch /opt/eap/standalone/deployments/kie-server.war.dodeploy

RUN /opt/eap/bin/add-user.sh -a -e -u admin -p admin -g "admin,rest-all,kie-server"
