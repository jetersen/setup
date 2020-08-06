$features = @{
  enable = @(
    'Microsoft-Windows-Subsystem-Linux',
    'Containers'
  )
  disable = @(
    # Internet Explorer 🤮
    # 'Internet-Explorer-Optional-amd64'
  )
}
$winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')
if ($winVer -ge 2004) {
  $features.enable += @('VirtualMachinePlatform')
}

if ($features.disable) {
  Disable-WindowsOptionalFeature -FeatureName $features.disable -Online -NoRestart | Out-Null
}
Enable-WindowsOptionalFeature -FeatureName $features.enable -Online -All -NoRestart | Out-Null
