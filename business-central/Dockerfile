# docker build -t business-central-3 business-central-3
# docker run -it -p 8080:8080 -p 9990:9990 business-central-3
FROM --platform=linux/amd64 registry.redhat.io/ibm-bamoe/bamoe-businesscentral-rhel8:8.0.6

USER root

RUN microdnf install vim sed

COPY bamoe-8.0.1-business-central-eap7-deployable.zip /tmp/

RUN unzip -o /tmp/bamoe-8.0.1-business-central-eap7-deployable.zip -d /tmp

RUN rsync -av /tmp/jboss-eap-7.4/. /opt/eap/ && rm -rf /tmp/jboss-eap-7.4

# Overwrite module.xml to reference the local JAR and integration artifact
# RUN sh -c "printf '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<module name=\"org.jboss.as.webservices\" xmlns=\"urn:jboss:module:1.9\">\n    <properties>\n        <property name=\"jboss.api\" value=\"private\"/>\n    </properties>\n    <exports>\n        <exclude path=\"org/jboss/as/webservices/logging\"/>\n    </exports>\n    <resources>\n        <artifact name=\"org.jboss.eap:wildfly-webservices-server-integration:7.4.21.GA-redhat-00001\"/>\n        <resource-root path=\"jbossws-cxf-resources-5.4.14.Final.jar\"/>\n    </resources>\n    <dependencies>\n        <module name=\"java.management\"/>\n        <module name=\"javax.annotation.api\"/>\n        <module name=\"javax.ejb.api\"/>\n        <module name=\"javax.jws.api\"/>\n        <module name=\"javax.servlet.api\"/>\n        <module name=\"javax.xml.ws.api\"/>\n        <module name=\"org.jboss.invocation\"/>\n        <module name=\"org.jboss.jandex\"/>\n        <module name=\"org.jboss.metadata.common\"/>\n        <module name=\"org.jboss.metadata.web\"/>\n        <module name=\"org.jboss.metadata.ear\"/>\n        <module name=\"org.jboss.metadata.ejb\"/>\n        <module name=\"org.jboss.staxmapper\"/>\n        <module name=\"org.jboss.as.controller\"/>\n        <module name=\"org.jboss.as.ejb3\"/>\n        <module name=\"org.jboss.as.server\"/>\n        <module name=\"org.jboss.as.ee\"/>\n        <module name=\"org.jboss.as.naming\"/>\n        <module name=\"org.jboss.as.network\"/>\n        <module name=\"org.jboss.as.security-plugins\"/>\n        <module name=\"org.wildfly.security.elytron-private\"/>\n        <module name=\"org.jboss.as.web-common\"/>\n        <module name=\"org.jboss.modules\"/>\n        <module name=\"org.jboss.msc\"/>\n        <module name=\"org.jboss.vfs\"/>\n        <module name=\"org.jboss.logging\"/>\n        <module name=\"org.jboss.ws.api\"/>\n        <module name=\"org.jboss.ws.common\" services=\"import\"/>\n        <module name=\"org.jboss.ws.spi\"/>\n        <module name=\"org.picketbox\"/>\n        <module name=\"org.wildfly.extension.undertow\"/>\n        <module name=\"io.undertow.core\"/>\n        <module name=\"io.undertow.servlet\"/>\n        <module name=\"org.wildfly.transaction.client\"/>\n        <module name=\"javax.transaction.api\"/>\n        <module name=\"org.jboss.as.weld.common\" optional=\"true\"/>\n        <module name=\"java.xml\"/>\n    </dependencies>\n</module>\n' > /opt/eap/modules/system/layers/base/org/jboss/as/webservices/main/module.xml"

# RUN chown -R jboss:jboss /opt/eap
# USER jboss

# Add a management user non-interactively
# RUN /opt/eap/bin/add-user.sh -a -u admin -p admin -r ApplicationRealm
RUN /opt/eap/bin/jboss-cli.sh --commands="embed-server --std-out=echo,/subsystem=elytron/filesystem-realm=ApplicationRealm:add-identity(identity=admin),/subsystem=elytron/filesystem-realm=ApplicationRealm:set-password(identity=admin, clear={password=admin}),/subsystem=elytron/filesystem-realm=ApplicationRealm:add-identity-attribute(identity=admin, name=role, value=[admin,rest-all,kie-server])"

# RUN mvn dependency:get -Dartifact=org.jboss.logmanager:jboss-logmanager:2.1.18.Final-redhat-00001 -Dtransitive=false -DremoteRepositories=https://maven.repository.redhat.com/ga

# RUN sed -i '/-Djava.awt.headless=true"/ s/"$/ -Djava.util.logging.manager=org.jboss.logmanager.LogManager"/' /opt/eap/bin/standalone.conf

COPY ./standalone.conf /opt/eap/bin/standalone.conf

CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
