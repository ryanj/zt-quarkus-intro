#!/bin/bash

USER=rhel

# --------------------------------------------------------------
# Reconfigure code-server
# --------------------------------------------------------------
sudo su - -c 'systemctl stop firewalld'
sudo su - -c 'systemctl stop code-server'
mv /home/rhel/.config/code-server/config.yaml /home/rhel/.config/code-server/config.bk.yaml

cat >/home/rhel/.config/code-server/config.yaml << EOF
bind-addr: 0.0.0.0:8080
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
cat /home/$USER/.local/share/code-server/User/settings.json

sudo su - -c 'systemctl start code-server'

exit 0
