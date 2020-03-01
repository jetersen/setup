Write-Host "Installing WSL"
choco install -y Microsoft-Windows-Subsystem-Linux --source="'windowsfeatures'"

$winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')
if ($winVer -ge 2004) {
  choco install -y VirtualMachinePlatform --source="'windowsfeatures'"
  RefreshEnv
  # wsl 2 rocks 🚀
    wsl --set-default-version 2
}
$item = "wsl-ubuntu-1804"
$file = "$env:TEMP\$item.appx"
Write-Host "Downloading $item"
curl.exe -sL https://aka.ms/$item -o $file
Add-AppxPackage $file
Remove-Item $file

RefreshEnv

Ubuntu1804 install --root
Ubuntu1804 run apt update
Ubuntu1804 run apt upgrade -y

Ubuntu1804 run wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
Ubuntu1804 run dpkg -i packages-microsoft-prod.deb
Ubuntu1804 run rm -f packages-microsoft-prod.deb

Ubuntu1804 run apt update
Ubuntu1804 run apt install -y apt-transport-https
Ubuntu1804 run apt update
Ubuntu1804 run apt install -y dotnet-sdk-3.1 aspnetcore-runtime-3.1 dotnet-runtime-3.1 dotnet-runtime-2.1

# pwsh

Ubuntu1804 run apt install -y powershell-preview
Ubuntu1804 run ln -sf /usr/bin/pwsh-preview /usr/bin/pwsh

# python

Ubuntu1804 run apt install -y python3 python3-venv python3-pip

# ruby

Ubuntu1804 run apt install -y ruby ruby-dev ruby-bundler zlib1g-dev

# nodejs

Ubuntu1804 run curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
Ubuntu1804 run apt install -y nodejs
