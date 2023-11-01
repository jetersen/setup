mkdir -p "/home/joseph/git/work" "/home/joseph/git/code"

git clone https://github.com/jetersen/dotfiles.git "/home/joseph/git/code/dotfiles"

/home/joseph/git/code/dotfiles/install.sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install awscli kubernetes-cli helm kustomize sops yq jandedobbeleer/oh-my-posh/oh-my-posh fluxcd/tap/flux
