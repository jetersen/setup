#Requires -RunAsAdministrator
# https://docs.microsoft.com/en-us/windows/application-management/apps-in-windows-10

# Credit to https://github.com/Sycnex/Windows10Debloater

#region license
# MIT License

# Copyright (c) 2017 Richard Newton

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#endregion

Function Remove-Bloat {

  $Bloatware = @(
    #Unnecessary Windows 10 AppX Apps
    "Microsoft.BingNews"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    #"Microsoft.RemoteDesktop"
    "Microsoft.SkypeApp"
    "Microsoft.StorePurchaseApp"
    "Microsoft.Office.Todo.List"
    #"Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    #"Microsoft.WindowsCamera"
    #"microsoft.windowscommunicationsapps" # Mail and Calendar
    #"Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    #"Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Duolingo-LearnLanguagesforFree*"
    "*PandoraMediaInc*"
    "*CandyCrush*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"
    #"*Spotify*"
    "*Minecraft*"
    "*Royal Revolt*"
    "*Sway*"
    "*Speed Test*"
    "*Dolby*"

    #Optional: Typically not removed but you can if you need to for some reason
    #"*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
    #"*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
    "*Microsoft.BingWeather*"
    #"*Microsoft.MSPaint*"
    #"*Microsoft.MicrosoftStickyNotes*"
    #"*Microsoft.Windows.Photos*"
    #"*Microsoft.WindowsCalculator*"
    #"*Microsoft.WindowsStore*"
  )
  foreach ($Bloat in $Bloatware) {
    $bloater = Get-AppxPackage -Name $Bloat
    $bloaterProvisioned = Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat
    if ($bloater) {
      Write-Output "Trying to remove $Bloat."
    }
    if ($bloaterProvisioned) {
      $bloaterProvisioned | Remove-AppxProvisionedPackage -Online | Out-Null
    }
  }
}

Function Remove-Keys {

  New-PSDrive HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null

  #These are the registry keys that it will delete.

  $Keys = @(

    #Remove Background Tasks
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"

    #Windows File
    "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"

    #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"

    #Scheduled Tasks to delete
    "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"

    #Windows Protocol Keys
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"

    #Windows Share Target
    "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
  )

  #This writes the output of each key it is removing and also removes the keys listed above.
  ForEach ($Key in $Keys) {
    if (Test-Path $Key) {
      Write-Output "Removing $Key from registry"
      Remove-Item $Key -Recurse
    }
  }
}

Function Protect-Privacy {

  #Disables Windows Feedback Experience
  Write-Output "Disabling Windows Feedback Experience program"
  $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
  If (Test-Path $Advertising) {
    Set-ItemProperty $Advertising Enabled -Value 0
  }

  #Stops Cortana from being used as part of your Windows Search Function
  Write-Output "Stopping Cortana from being used as part of your Windows Search Function"
  $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
  If (Test-Path $Search) {
    Set-ItemProperty $Search AllowCortana -Value 0
  }

  #Disables Web Search in Start Menu
  Write-Output "Disabling Bing Search in Start Menu"
  $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
  Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0
  If (!(Test-Path $WebSearch)) {
    New-Item $WebSearch
  }
  Set-ItemProperty $WebSearch DisableWebSearch -Value 1

  #Prevents bloatware applications from returning and removes Start Menu suggestions
  Write-Output "Adding Registry key to prevent bloatware apps from returning"
  $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
  $registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
  If (!(Test-Path $registryPath)) {
    New-Item $registryPath
  }
  Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1

  If (!(Test-Path $registryOEM)) {
    New-Item $registryOEM
  }
  Set-ItemProperty $registryOEM ContentDeliveryAllowed -Value 0
  Set-ItemProperty $registryOEM OemPreInstalledAppsEnabled -Value 0
  Set-ItemProperty $registryOEM PreInstalledAppsEnabled -Value 0
  Set-ItemProperty $registryOEM PreInstalledAppsEverEnabled -Value 0
  Set-ItemProperty $registryOEM SilentInstalledAppsEnabled -Value 0
  Set-ItemProperty $registryOEM SystemPaneSuggestionsEnabled -Value 0

  #Preping mixed Reality Portal for removal
  Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
  $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"
  If (Test-Path $Holo) {
    Set-ItemProperty $Holo FirstRunSucceeded -Value 0
  }

  #Disables Wi-fi Sense
  Write-Output "Disabling Wi-Fi Sense"
  $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
  $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
  $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
  If (!(Test-Path $WifiSense1)) {
    New-Item $WifiSense1
  }
  Set-ItemProperty $WifiSense1 Value -Value 0
  If (!(Test-Path $WifiSense2)) {
    New-Item $WifiSense2
  }
  Set-ItemProperty $WifiSense2 Value -Value 0
  Set-ItemProperty $WifiSense3 AutoConnectAllowedOEM -Value 0

  #Disables live tiles
  Write-Output "Disabling live tiles"
  $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
  If (!(Test-Path $Live)) {
    New-Item $Live
  }
  Set-ItemProperty $Live NoTileApplicationNotification -Value 1

  #Disabling Location Tracking
  Write-Output "Disabling Location Tracking"
  $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
  $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
  If (!(Test-Path $SensorState)) {
    New-Item $SensorState
  }
  Set-ItemProperty $SensorState SensorPermissionState -Value 0
  If (!(Test-Path $LocationConfig)) {
    New-Item $LocationConfig
  }
  Set-ItemProperty $LocationConfig Status -Value 0

  #Disables People icon on Taskbar
  Write-Output "Disabling People icon on Taskbar"
  $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
  If (Test-Path $People) {
    Set-ItemProperty $People -Name PeopleBand -Value 0
  }

  #Disables scheduled tasks that are considered unnecessary
  Write-Output "Disabling scheduled tasks"
  $tasks = Get-ScheduledTask
  $tasks | Where-Object TaskName -eq "XblGameSaveTaskLogon" | Disable-ScheduledTask
  $tasks | Where-Object TaskName -eq "XblGameSaveTask" | Disable-ScheduledTask
  $tasks | Where-Object TaskName -eq "Consolidator" | Disable-ScheduledTask
  $tasks | Where-Object TaskName -eq "UsbCeip" | Disable-ScheduledTask
  $tasks | Where-Object TaskName -eq "DmClient" | Disable-ScheduledTask
  $tasks | Where-Object TaskName -eq "DmClientOnScenarioDownload" | Disable-ScheduledTask

  $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
  If (Test-Path $CloudStore) {
    Write-Output "Removing CloudStore from registry"
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0
    Stop-Process -ProcessName "explorer" -Force
    Remove-Item $CloudStore -Recurse -Force
    Start-Process "Explorer.exe" -Wait
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 1
  }
}

Remove-Bloat
Remove-Keys
Protect-Privacy
