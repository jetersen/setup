#Requires -RunAsAdministrator

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# enable TLS 1.2 on 64 bit .Net Framework
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v2.0.50727' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v2.0.50727' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord

# enable TLS 1.2 on 32 bit .Net Framework
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value '1' -Type DWord

.\debloat.ps1

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# $winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')

# gpg home dir should be inside userprofile, otherwise git will have a field day 😅
[Environment]::SetEnvironmentVariable("GNUPGHOME", "%USERPROFILE%\.gnupg", "Machine")

.\features.ps1

choco feature enable -n allowGlobalConfirmation

scoop bucket add extras
scoop bucket add nerd-fonts

choco install chocolatey-core.extension vcredist2015 googlechrome vscode.install powershell-preview
choco install dotnetcore-sdk --version=2.1.804 --side-by-side
choco install dotnetcore-sdk --version=3.1.102 --side-by-side

# Workaround for powershell preview not on path as `pwsh`
$env:Path += ";C:\Program Files\PowerShell\7-preview"
[Environment]::SetEnvironmentVariable("Path", $env:Path, "Machine")

scoop install git gpg4win greenshot gsudo hub jetbrains-mono rapidee slack jetbrains-toolbox nodejs python

.\gpg.ps1

# Schedule wsldistro.ps1
$scriptlocation = Get-ChildItem .\features.ps1 | Select-Object -ExpandProperty FullName
$TaskTrigger = (New-ScheduledTaskTrigger -atstartup)
$TaskAction = New-ScheduledTaskAction -Execute pwsh.exe -argument "$scriptlocation"
$TaskUserID = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -RunLevel Highest
Register-ScheduledTask -Force -TaskName InstallWSLDistro -Action $TaskAction -Principal $TaskUserID -Trigger $TaskTrigger
