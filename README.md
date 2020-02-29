# Personal setup

I frequently need to run my setup, so I written it into scripts.

## one liner

Best run as administrator

Use curl.exe to avoid enabling TLS 1.2 for Windows Powershell
```powershell
Invoke-Expression ((curl.exe -sL https://raw.githubusercontent.com/casz/setup/master/run.ps1) -join "`n")
```

Another option
```powershell
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/casz/setup/master/run.ps1')
```
