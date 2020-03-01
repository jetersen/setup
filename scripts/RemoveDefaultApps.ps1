#--- Uninstall unnecessary applications that come with Windows out of the box ---
if ((Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent").DisableWindowsConsumerFeatures -ne 1) {
  Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"

  function removeApp {
    Param ([string]$appName)
    Write-Output "Trying to remove $appName"
    Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $appName | Remove-AppxProvisionedPackage -Online
  }

  $applicationList = @(
    "Microsoft.BingFinance"
    "Microsoft.3DBuilder"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingWeather"
    "Microsoft.CommsPhone"
    "Microsoft.Getstarted"
    "Microsoft.WindowsMaps"
    "*MarchofEmpires*"
    "Microsoft.StorePurchaseApp"
    "Microsoft.Office.Todo.List"
    "Microsoft.GetHelp"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.Messaging"
    "*Minecraft*"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.OneConnect"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "*Solitaire*"
    "Microsoft.WindowsAlarms"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.XboxApp"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.SkypeApp"
    "Microsoft.FreshPaint"
    "Microsoft.Print3D"
    "Microsoft.People"
    "*Autodesk*"
    "*BubbleWitch*"
    "king.com*"
    "G5*"
    "*Dell*"
    "*Facebook*"
    "*Keeper*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Netflix*"
    "*CandyCrush*"
    "*PandoraMediaInc*"
    "*Twitter*"
    "*Plex*"
    "*Dolby*"
    "*Speed Test*"
    "*Royal Revolt*"
    "*.Duolingo-LearnLanguagesforFree"
    "*.EclipseManager"
    "ActiproSoftwareLLC.562882FEEB491" # Code Writer
    "*.AdobePhotoshopExpress"
  );

  foreach ($app in $applicationList) {
    removeApp $app
  }

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

  #Prevents bloatware applications from returning and removes Start Menu suggestions
  Write-Output "Adding Registry key to prevent bloatware apps from returning"
  $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
  $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent\DisableWindowsConsumerFeatures"
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
}
