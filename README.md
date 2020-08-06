# Personal setup

I frequently need to run my setup, so I written it into scripts.

## ClickOnce Internet Explorer

If you feel like [clicking here](https://boxstarter.org/package/url?https://raw.githubusercontent.com/jetersen/setup/master/windows.ps1) (*Does not work on chrome/edge/firefox*)

## Install from Windows Powershell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force `
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 `
iex ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')) `
Get-Boxstarter -Force `
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/jetersen/setup/master/windows.ps1
```
