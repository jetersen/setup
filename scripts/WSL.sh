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

function install_awscli {
  echo "Installing awscli..."
  [ -d /usr/local/aws ] && sudo rm -rf /usr/local/aws
  [ -f /usr/local/bin/aws ] && sudo rm /usr/local/bin/aws
  curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -qq -d /tmp/ /tmp/awscliv2.zip
  sudo /tmp/aws/install --install-dir /usr/local/aws-cli --bin-dir /usr/local/bin &> /dev/null # for installation
  rm /tmp/awscliv2.zip
  rm -rf /tmp/aws
}

which aws || install_awscli

if id "joseph" &>/dev/null; then
  echo 'user exists'
else
  # create user
  useradd -m -s "$(which bash)" -G sudo,docker joseph
  echo 'joseph:changeit' | chpasswd

  echo 'changeit' | su joseph

  chsh joseph -s /usr/bin/zsh

  # ASDF
  git clone https://github.com/asdf-vm/asdf.git "/home/joseph/.asdf" --branch v0.8.1
  . "/home/joseph/.asdf/asdf.sh"

  plugins=$(echo "argocd
    github-cli
    helm
    helmfile
    kops
    kubectl
    kustomize
    sops
  " | tr -d '[:blank:]')

  # install latest
  # asdf plugin list | xargs -r -I % -d\\n -n1 bash -c 'asdf install % latest'
  # uninstall old versions:
  # asdf plugin list | xargs -r -I % -d\\n -n1 bash -c 'asdf list % | tr -d "[:blank:]" | sort -rV | tail +2 | xargs -r -d\\n -n1 asdf uninstall %'
  # update global tool versions
  # asdf plugin list | xargs -r -I % -d\\n -n1 bash -c 'asdf list % | tr -d "[:blank:]" | sort -rV | head | xargs -r -d\\n -n1 asdf global %'
  echo "${plugins}" | xargs -d\\n -n1 asdf plugin add
  echo "${plugins}" | xargs -I % -d\\n -n1 bash -c 'asdf install % latest'
  echo "${plugins}" | xargs -r -I % -d\\n -n1 bash -c 'asdf list % | tr -d "[:blank:]" | sort -rV | head | xargs -r -d\\n -n1 asdf global %'

  mkdir -p "/home/joseph/git/work" "/home/joseph/git/code"

  git clone https://github.com/jetersen/dotfiles.git "/home/joseph/git/code/dotfiles"
fi
