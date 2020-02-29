#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

$owner = "casz"
$repo = "setup"
New-Item -ItemType Directory -Force -Path \git\code | Out-Null
Set-Location \git\code
Invoke-WebRequest -Uri "https://github.com/$owner/$repo/archive/master.zip" -OutFile .\$repo.zip
Expand-Archive -Path .\$repo.zip -DestinationPath .\ -Force
Move-Item "$repo-master" "$repo"
Remove-Item -Force .\*.zip
Set-Location "$repo"
.\windows.ps1
