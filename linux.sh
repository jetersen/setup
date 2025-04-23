#!/usr/bin/env bash
source /etc/os-release

git_clone_or_pull() {
    local dir="$HOME/git/code/setup"
    local repo_url="https://github.com/jetersen/setup.git"

    if [ ! -d "$dir" ]; then
        mkdir -p "$(dirname "$dir")"
        git clone "$repo_url" "$dir"
    else
        git -C "$dir" pull --autostash --rebase
    fi
}

if [[ $ID == "fedora" ]]; then
    echo "This is Fedora 🤠"
    if ! command -v git &> /dev/null; then
      echo "git could not be found, installing..."
      sudo dnf install -y git
    fi

    git_clone_or_pull
    $HOME/git/code/setup/scripts/fedora.sh
elif [[ $ID == "cachyos" ]]; then
    echo "This is CachyOS 💾🐧"
    if ! command -v git &> /dev/null; then
      echo "git could not be found, installing..."
      sudo pacman -S --noconfirm git
    fi

    git_clone_or_pull
    $HOME/git/code/setup/scripts/cachyos.fish
else
    echo "I haven't had the need to explore $ID OS yet."
    exit 1
fi
