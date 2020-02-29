#Requires -RunAsAdministrator
$owner = "casz"
$repo = "setup"
Invoke-WebRequest -Uri "https://github.com/$owner/$repo/archive/master.zip" -OutFile .\$repo.zip
Expand-Archive -Path .\$repo.zip -DestinationPath .\ -Force
Remove-Item -Force .\*.zip
.\windows.ps1
