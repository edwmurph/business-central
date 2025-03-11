# business-central

## Getting Started

1. Login to red hat container registry:

```bash
docker login https://registry.redhat.io
```

2. Run containers

```bash
docker compose up
```

## EAP

```bash
/opt/eap/bin/jboss-cli.sh --connect

/subsystem=ejb3:read-resource(recursive=true)
```

## References

https://docs.jbpm.org/7.74.1.Final/jbpm-docs/html_single/#_jbpmoverview

https://github.com/jboss-dockerfiles/business-central/tree/main/showcase

https://www.jbpm.org/learn/gettingStartedUsingDocker.html

https://quay.io/repository/kiegroup/business-central-workbench-showcase?tab=tags&tag=latest

Learn Business Central:
https://www.ibm.com/docs/en/ibamoe/8.0.x

Installation on EAP:
https://www.ibm.com/docs/en/ibamoe/8.0.x?topic=configuring-installing-red-hat-jboss-eap

Guide:
https://community.ibm.com/community/user/automation/blogs/marco-antonioni/2022/09/24/setup-ibm-process-automation-manager-open-edition

Downloads:
https://early-access.ibm.com/software/support/trial/cst/programwebsite.wss?siteId=1856&tabId=5158&p=&h=null

Worked:
https://github.com/timwuthenow/ibamoe-setup/tree/main
