$file = "$env:TEMP\ubuntu-1804.appx"
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile $file -UseBasicParsing
Add-AppxPackage $file
Remove-Item $file
Get-ScheduledTask | Where-Object TaskName -eq "InstallWSLDistro" | Unregister-ScheduledTask -Confirm:$false
