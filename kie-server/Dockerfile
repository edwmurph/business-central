FROM --platform=linux/amd64 registry.redhat.io/ibm-bamoe/bamoe-kieserver-rhel8:8.0.6

USER root

RUN microdnf install vim sed

COPY bamoe-8.0.1-kie-server-ee8.zip /tmp/

RUN unzip -o /tmp/bamoe-8.0.1-kie-server-ee8.zip -d /tmp

RUN ls -la /tmp

# RUN rsync -av /tmp/jboss-eap-7.4/. /opt/eap/ && rm -rf /tmp/jboss-eap-7.4

# RUN /opt/eap/bin/jboss-cli.sh --commands="embed-server --std-out=echo,/subsystem=elytron/filesystem-realm=ApplicationRealm:add-identity(identity=admin),/subsystem=elytron/filesystem-realm=ApplicationRealm:set-password(identity=admin, clear={password=admin}),/subsystem=elytron/filesystem-realm=ApplicationRealm:add-identity-attribute(identity=admin, name=role, value=[admin,rest-all,kie-server])"
# RUN /opt/eap/bin/jboss-cli.sh --commands="embed-server --std-out=echo,/subsystem=elytron/properties-realm=ApplicationRealm:add-identity(identity=admin),/subsystem=elytron/properties-realm=ApplicationRealm:set-password(identity=admin,clear={password=admin}),/subsystem=elytron/properties-realm=ApplicationRealm:add-identity-attribute(identity=admin,name=role,value=[admin,rest-all,kie-server])"

COPY ./standalone.xml /opt/eap/bin/standalone.xml

CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
