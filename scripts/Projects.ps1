$folder = "C:\git\code"
New-Item $folder -ItemType Directory
Set-location $folder
git clone https://github.com/casz/dotfiles.git
git clone https://github.com/casz/setup.git

$folder = "C:\git\work"
New-Item $folder -ItemType Directory
