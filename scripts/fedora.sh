#!/usr/bin/env bash

echo "Going to ask for sudo password to install packages"
if sudo -v; then
  echo "Thanks! ☺️"
else
  echo "Sudo password is required to proceed."
  exit 1
fi

# install ansible-core
if ! command -v ansible-playbook &> /dev/null; then
  sudo dnf install -y ansible-core
fi

scriptDir=$(dirname $(readlink -f $0))

# run fedora playbook
ansible-playbook "$scriptDir/../playbooks/fedora.yml"

sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

curl -sSL -o ~/Downloads/packages-microsoft-prod.rpm https://packages.microsoft.com/config/rhel/9/packages-microsoft-prod.rpm

sudo rpm -i ~/Downloads/packages-microsoft-prod.rpm

rm ~/Downloads/packages-microsoft-prod.rpm

# Edit /etc/yum.repos.d/microsoft-prod.repo and exclude dotnet* packages as they are included in the updates repo
content=$(cat /etc/yum.repos.d/microsoft-prod.repo)
if [[ $content == *"exclude="* ]]; then
  if [[ $content == *"dotnet*"* ]]; then
    echo "dotnet* already excluded"
  else
    # keep the existing exclude and add dotnet*
    sudo sed -i 's/exclude=/exclude=dotnet* /' /etc/yum.repos.d/microsoft-prod.repo
  fi
else
  # append exclude=dotnet* to the end of the file
  echo "exclude=dotnet*" | sudo tee -a /etc/yum.repos.d/microsoft-prod.repo > /dev/null
fi

sudo dnf config-manager addrepo --from-repofile https://downloads.k8slens.dev/rpm/lens.repo

echo "Installing packages"
sudo dnf install -y --skip-unavailable \
  btop curl git jq yq zsh fastfetch \
  hunspell-da gh eza helm kubernetes-client \
  powershell code dotnet-sdk-8.0 lens awscli2 git-delta jetbrains-mono-fonts

mkdir -p $HOME/.local/bin $HOME/.local/share/fonts $HOME/git/code $HOME/git/work

git clone https://github.com/jetersen/dotfiles.git $HOME/git/code/dotfiles

$HOME/git/code/dotfiles/install.sh

echo "Fix vscode"
tee $HOME/.config/code-flags.conf > /dev/null <<EOF
--enable-features=UseOzonePlatform
--ozone-platform=wayland
EOF

echo "Install flatpaks"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.slack.Slack com.spotify.Client dev.vencord.Vesktop

# detect nvidia card
lspci | grep 'VGA.*NVIDIA' && sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda

# Install Jetbrains Toolbox
# check ~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox does not exist and install if it does not

if [ ! -f $HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox ]; then
  jetbrains_toolbox_url=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | jq -r '.TBA[0].downloads.linux.link')
  curl -sSfL $jetbrains_toolbox_url -o $HOME/Downloads/jetbrains-toolbox.tar.gz
  tar -xzf $HOME/Downloads/jetbrains-toolbox.tar.gz -C $HOME/Downloads
  $HOME/Downloads/jetbrains-toolbox-*/jetbrains-toolbox
  rm -rf $HOME/Downloads/jetbrains-toolbox*
fi

# Install JetBrains Mono Nerd Font
if [ ! -f $HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf ]; then
  curl -sSfL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip -o $HOME/Downloads/JetBrainsMono.zip
  unzip -q -o $HOME/Downloads/JetBrainsMono.zip -d $HOME/Downloads/JetBrainsMono
  mv $HOME/Downloads/JetBrainsMono/JetBrainsMonoNerdFont-*.ttf $HOME/.local/share/fonts
  fc-cache -f -v
  rm -rf $HOME/Downloads/JetBrainsMono*
fi

# Install Bitwarden CLI
if [ ! -f $HOME/.local/bin/bw ]; then
  curl -sSfL 'https://vault.bitwarden.com/download/?app=cli&platform=linux' -o $HOME/Downloads/bitwarden-cli.zip
  unzip -q -o $HOME/Downloads/bitwarden-cli.zip -d $HOME/Downloads/bitwarden-cli
  mv $HOME/Downloads/bitwarden-cli/bw $HOME/.local/bin
  chmod +x $HOME/.local/bin/bw
  rm -rf $HOME/Downloads/bitwarden-cli*
fi


read -p "Do you want to install gaming packages? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo dnf install -y steam lutris
fi
