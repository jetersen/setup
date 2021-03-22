$folder = "C:\git\code"
New-Item $folder -ItemType Directory
git clone https://github.com/jetersen/dotfiles.git "$folder\dotfiles"
git clone https://github.com/jetersen/setup.git "$folder\setup"

$folder = "C:\git\work"
New-Item $folder -ItemType Directory
