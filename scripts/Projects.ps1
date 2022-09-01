$folder = "C:\git\code"
if ([System.IO.File]::Exists("${folder}") -eq $false) {
  New-Item $folder -ItemType Directory
}

$folder = "C:\git\work"
if ([System.IO.File]::Exists("${folder}") -eq $false) {
  New-Item $folder -ItemType Directory
}
