$folder = "C:\git\code"
if ([System.IO.File]::Exists("${folder}") -eq $false) {
  New-Item $folder -ItemType Directory
}
git clone https://github.com/jetersen/dotfiles.git "${folder}\dotfiles"
git clone https://github.com/jetersen/setup.git "${folder}\setup"

$folder = "C:\git\work"
if ([System.IO.File]::Exists("${folder}") -eq $false) {
  New-Item $folder -ItemType Directory
}
