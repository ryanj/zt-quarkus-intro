#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "Setup vm control01" > /tmp/progress.log

chmod 666 /tmp/progress.log 

#dnf install -y nc


##Imported init from Instruqt:
curl https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/scripts/install_java_graalvm.sh | bash

mkdir -p /root/projects/quarkus
rm -Rf /root/projects/quarkus/getting-started
echo "-w \"\n\"" >> ~/.curlrc
