export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y

wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm -f packages-microsoft-prod.deb

apt-get update
apt-get install -y apt-transport-https
apt-get update
apt-get install -y dotnet-sdk-5.0 dotnet-sdk-3.1

# python

apt-get install -y python3 python3-venv python3-pip

# ruby

apt-get install -y ruby ruby-dev ruby-bundler zlib1g-dev

# nodejs

curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs

apt-get install zsh

# create user

useradd -m -s "$(which bash)" -G sudo joseph
echo 'joseph:changeit' | chpasswd

echo 'changeit' | su joseph
clear

# ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
. $HOME/.asdf/asdf.sh
asdf plugin add kubectl
asdf plugin add kops
asdf plugin add github-cli
asdf plugin add sops
asdf plugin add helmfile
asdf plugin add argocd
asdf plugin add helm
adsf plugin add rke
asdf install kubectl 1.19.5
asdf install kops v1.19.1
asdf install github-cli 1.7.0
asdf install sops v3.6.1
asdf install helmfile 0.129.3
asdf install argocd 1.8.4
asdf install helm 3.4.1
asdf install rke v1.2.3

mkdir -p git/work git/code

git clone https://github.com/jetersen/dotfiles.git "$HOME/git/code/dotfiles"
