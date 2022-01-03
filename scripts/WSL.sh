export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y

wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm -f packages-microsoft-prod.deb

apt-get update
apt-get install -y apt-transport-https
apt-get update
apt-get install -y dotnet-sdk-6.0

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

  chsh joseph -s /usr/bin/zsh

  echo 'changeit' | sudo -S -u joseph bash -c "curl -sL 'https://raw.githubusercontent.com/jetersen/setup/main/scripts/user.sh' | bash"
fi
