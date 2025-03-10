# business-central

## Getting Started

0. Login to red hat container registry:

```bash
docker login https://registry.redhat.io
```

1. Build bamoe image:

```bash
docker buildx build --platform=linux/amd64 -t bamoe .
```

2. Run the bamoe image:

```bash
docker run --platform=linux/amd64 -p 8080:8080 bamoe
```

or start interactive shell:

```bash
docker run -it --platform=linux/amd64 bamoe
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
