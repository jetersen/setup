# Description: Boxstarter Script
# Author: Joseph Petersen
# My Personal Setup

Disable-UAC
Disable-MicrosoftUpdate

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
Write-Host "helper script base URI is $helperUri"

function ExecuteScript {
  Param ([string]$script)
  Write-Host "executing $helperUri/$script ..."
  Invoke-Expression ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

if (!$env:ChocolateyInstall) {
  $env:ChocolateyInstall = "C:\ProgramData\chocolatey"
}
$chocoProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if ([System.IO.File]::Exists("$chocoProfile")) {
  Import-Module "$chocoProfile"
}

ExecuteScript "SystemConfiguration.ps1"
ExecuteScript "Winget.ps1"
ExecuteScript "Features.ps1"
ExecuteScript "RemoveDefaultApps.ps1"
ExecuteScript "DevTools.ps1"
ExecuteScript "WSL.ps1"
ExecuteScript "Fonts.ps1"
ExecuteScript "Projects.ps1"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
