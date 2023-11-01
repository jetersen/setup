export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y
# Install pre-requisite packages.
apt-get install -y apt-transport-https software-properties-common

sudo add-apt-repository ppa:wslutilities/wslu

curl -sSfL "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" -o packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm -f packages-microsoft-prod.deb

cat >/etc/apt/preferences <<EOL
Package: dotnet* aspnet* netstandard*
Pin: origin "packages.microsoft.com"
Pin-Priority: -10
EOL

curl -sSfL https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /usr/share/keyrings/githubcli-archive-keyring.gpg >/dev/null
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null

apt-get update

apt-get install -y dotnet-sdk-7.0 gh zsh powershell wslu build-essential procps curl file git

if id "joseph" &>/dev/null; then
  echo 'user exists'
else
  # create user
  useradd -m -s "$(which bash)" -G sudo joseph
  echo 'joseph:changeit' | chpasswd

  chsh joseph -s /usr/bin/zsh

  echo 'changeit' | sudo -S -u joseph bash -c "curl -sL 'https://raw.githubusercontent.com/jetersen/setup/main/scripts/user.sh' | bash"
fi
