$folder = "C:\git\code"
New-Item $folder -ItemType Directory
Set-location $folder
git clone https://github.com/jetersen/dotfiles.git
git clone https://github.com/jetersen/setup.git

$folder = "C:\git\work"
New-Item $folder -ItemType Directory
