#!/usr/bin/env bash

echo "Going to ask for sudo password to install packages"
if sudo -v; then
  echo "Thanks! ☺️"
else
  echo "Sudo password is required to proceed."
  exit 1
fi

# install ansible
if ! command -v ansible-playbook &> /dev/null; then
  sudo dnf install -y ansible
fi

scriptDir=$(dirname $(readlink -f $0))

# run fedora playbook
ansible-playbook "$scriptDir/../playbooks/fedora.yml"
