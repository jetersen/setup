# Personal setup

I frequently need to run my setup, so I written it into scripts.

## ClickOnce Microsoft Edge

* [Home Setup](https://boxstarter.org/package/url?https://raw.githubusercontent.com/jetersen/setup/main/windows-home.ps1)
* [Work Setup](https://boxstarter.org/package/url?https://raw.githubusercontent.com/jetersen/setup/main/windows-work.ps1)

## Backup ways to run

### ClickOnce Chromium Edge

```powershell
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"; New-Item $path -Force | Out-Null; Set-ItemProperty -LiteralPath "$PATH" ClickOnceEnabled 1; start https://boxstarter.org/package/url?https://raw.githubusercontent.com/jetersen/setup/main/windows-home.ps1
```

### Install from Windows Powershell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force `
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 `
iex ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')) `
Get-Boxstarter -Force `
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/jetersen/setup/main/windows-home.ps1
```

## Linux

```bash
curl -s https://raw.githubusercontent.com/jetersen/setup/main/linux.sh | bash
```
