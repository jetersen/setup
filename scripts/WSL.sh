export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y
# Install pre-requisite packages.
apt-get install -y apt-transport-https software-properties-common

curl -sSfL "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" -o packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm -f packages-microsoft-prod.deb

curl -sSfL https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /usr/share/keyrings/githubcli-archive-keyring.gpg >/dev/null
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null

apt-get update

apt-get install -y dotnet-sdk-7.0 gh zsh powershell

function install_awscli {
  echo "Installing awscli..."
  [ -d /usr/local/aws ] && rm -rf /usr/local/aws
  [ -f /usr/local/bin/aws ] && rm /usr/local/bin/aws
  curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -qq -d /tmp/ /tmp/awscliv2.zip
  /tmp/aws/install --install-dir /usr/local/aws-cli --bin-dir /usr/local/bin &> /dev/null # for installation
  rm /tmp/awscliv2.zip
  rm -rf /tmp/aws
}

which aws || install_awscli

if id "joseph" &>/dev/null; then
  echo 'user exists'
else
  # create user
  useradd -m -s "$(which bash)" -G sudo joseph
  echo 'joseph:changeit' | chpasswd

  chsh joseph -s /usr/bin/zsh

  echo 'changeit' | sudo -S -u joseph bash -c "curl -sL 'https://raw.githubusercontent.com/jetersen/setup/main/scripts/user.sh' | bash"
fi
