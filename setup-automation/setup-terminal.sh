#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "Setup vm control01" > /tmp/progress.log

chmod 666 /tmp/progress.log 

#dnf install -y nc
# Install VSCode
curl -fsSL https://code-server.dev/install.sh | sh

cat >/home/rhel/.config/code-server/config.yaml << EOF
bind-addr: 0.0.0.0:9090
auth: none
cert: false
disable-update-check: true
EOF

cat >/home/$USER/.local/share/code-server/User/settings.json <<EOL
{
  "git.ignoreLegacyWarning": true,
  "window.menuBarVisibility": "visible",
  "git.enableSmartCommit": true,
  "workbench.tips.enabled": false,
  "workbench.startupEditor": "readme",
  "telemetry.enableTelemetry": false,
  "search.smartCase": true,
  "git.confirmSync": false,
  "workbench.colorTheme": "Solarized Dark",
  "update.showReleaseNotes": false,
  "update.mode": "none",
  "ansible.ansibleLint.enabled": false,
  "ansible.ansible.useFullyQualifiedCollectionNames": true,
  "files.associations": {
      "*.yml": "ansible",
      "*.yaml": "ansible"
  },
  "files.exclude": {
    "**/.*": true
  },
  "files.watcherExclude": {
    "**": true
  },
  "files.watcherExclude": {
    "**": true
  },
  "security.workspace.trust.enabled": false,
  "redhat.telemetry.enabled": false,
  "ansibleLint.enabled": false,
  "ansible.validation.lint.enabled": false,
  "ansible.validation.enabled": false,
  "ansible.lightspeed.enabled": false,
  "ansible.lightspeed.suggestions.enabled": false
  "python.useEnvironmentsExtension": false
}
EOL

sudo systemctl enable --now code-server@$USER

##Imported init from Instruqt:
export GRAALVM_VERSION=22.3.1
export MVN_VERSION=3.8.6

mkdir -p /opt/java
curl -sL https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz -o /tmp/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz
tar -xvf /tmp/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz -C /opt/java/
rm -fr /tmp/graalvm-ce-java17-linux-amd64-${GRAALVM_VERSION}.tar.gz

curl -s https://archive.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz
tar -xzvf /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt/java/
rm -fr /tmp/apache-maven-${MVN_VERSION}-bin.tar.gz

echo "export GRAALVM_HOME=/opt/java/graalvm-ce-java17-${GRAALVM_VERSION}/" >> /home/rhel/.bashrc
echo 'export JAVA_HOME=$GRAALVM_HOME' >> /home/rhel/.bashrc
echo "export MAVEN_HOME=/opt/java/apache-maven-${MVN_VERSION}/" >> /home/rhel/.bashrc
echo 'export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"'  >> /home/rhel/.bashrc

mkdir -p /home/rhel/projects/quarkus
echo "-w \"\n\"" >> /home/rhel/.curlrc
chown -R rhel.rhel /home/rhel
