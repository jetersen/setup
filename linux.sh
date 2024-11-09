#!/usr/bin/env bash
source /etc/os-release
if [[ $ID == "fedora" ]]; then
    echo "This is Fedora 🤠"
    if ! command -v git &> /dev/null; then
      echo "git could not be found, installing..."
      sudo dnf install -y git
    fi

    mkdir -p $HOME/git/code
    git clone https://github.com/jetersen/setup.git $HOME/git/code/setup
    $HOME/git/code/setup/scripts/fedora.sh
else
    echo "I haven't had the need to explore $ID OS yet."
    exit 1
fi
