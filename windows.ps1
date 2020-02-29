#Requires -RunAsAdministrator

$owner = "casz"
$repo = "setup"

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

scoop install git

scoop bucket add extras
scoop bucket add nerd-fonts

choco install chocolatey-core.extension vcredist2015 googlechrome vscode.install powershell-preview python3 nodejs.install
choco install dotnetcore-sdk --version=2.1.804 --side-by-side
choco install dotnetcore-sdk --version=3.1.102 --side-by-side

# scoop install gpg4win
scoop install greenshot gsudo hub jetbrains-mono rapidee slack jetbrains-toolbox

# Chocolatey update the $ENV:PATH
$chocoProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (!(Test-Path "$chocoProfile")) {
  $env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
  $chocoProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
}

Import-Module "$chocoProfile"
RefreshEnv

# Fix GnuPG adding itself to path incorrectly:
# $env:Path = $env:Path -replace '[^;]+Gpg4win\\\.\.\\GnuPG\\bin;'

# Workaround for powershell preview not on path as `pwsh`
$env:Path += ";C:\Program Files\PowerShell\7-preview"

[Environment]::SetEnvironmentVariable("Path", $env:Path, "Machine")

# fix setup repo to be connected to git
if (!(Test-Path ".\.git")) {
  git init
  git remote add origin "https://github.com/$owner/$repo.git"
  git fetch
  git reset --hard origin/master
}

# .\gpg.ps1

# Schedule wsldistro.ps1
.\wsldistro.ps1

Start-Sleep -Seconds 2

Restart-Computer -Force
