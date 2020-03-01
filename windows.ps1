# Description: Boxstarter Script
# Author: Joseph Petersen
# My Personal Setup

Disable-UAC

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

choco feature disable --name showDownloadProgress

ExecuteScript "SystemConfiguration.ps1"
ExecuteScript "FileExplorerSettings.ps1"
ExecuteScript "PowerShell7.ps1"
ExecuteScript "RemoveDefaultApps.ps1"
ExecuteScript "VSCode.ps1"
ExecuteScript "DevTools.ps1"
ExecuteScript "HyperV.ps1"
ExecuteScript "Docker.ps1"
ExecuteScript "WSL.ps1"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
