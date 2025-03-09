FROM --platform=linux/amd64 registry.redhat.io/ibm-bamoe/bamoe-businesscentral-rhel8:8.0.6

USER root

RUN microdnf install vim sed

COPY bamoe-8.0.1-business-central-eap7-deployable.zip /tmp/

RUN unzip -o /tmp/bamoe-8.0.1-business-central-eap7-deployable.zip -d /tmp

RUN rsync -av /tmp/jboss-eap-7.4/. /opt/eap/ && rm -rf /tmp/jboss-eap-7.4

RUN /opt/eap/bin/jboss-cli.sh --commands="embed-server --std-out=echo,/subsystem=elytron/filesystem-realm=ApplicationRealm:add-identity(identity=admin),/subsystem=elytron/filesystem-realm=ApplicationRealm:set-password(identity=admin, clear={password=admin}),/subsystem=elytron/filesystem-realm=ApplicationRealm:add-identity-attribute(identity=admin, name=role, value=[admin,rest-all,kie-server])"

COPY ./standalone.conf /opt/eap/bin/standalone.conf
# https://docs.redhat.com/en/documentation/red_hat_process_automation_manager/7.11/html/managing_red_hat_process_automation_manager_and_kie_server_settings/migration-configure-kie-server-proc#migration-configure-kie-server-proc
# COPY ./standalone.xml /opt/eap/standalone/configuration/standalone.xml

CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
