#!/bin/bash
VER=$(lsb_release -sr) # like `18.04`

# dotnet

wget -q https://packages.microsoft.com/config/ubuntu/${VER}/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm -f packages-microsoft-prod.deb

sudo apt update
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y dotnet-sdk-3.1 aspnetcore-runtime-3.1 dotnet-runtime-3.1 dotnet-runtime-2.1

# pwsh

sudo apt-get install -y powershell-preview
sudo ln -sf /usr/bin/pwsh-preview /usr/bin/pwsh

# python
sudo apt install python3 python3-venv python3-pip

# gpg

pwsh ./gpg.ps1
