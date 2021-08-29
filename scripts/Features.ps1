$features = @{
  enable = @(
    'Microsoft-Windows-Subsystem-Linux',
    'VirtualMachinePlatform'
    'Containers'
  )
  disable = @(
    # Internet Explorer 🤮
    # 'Internet-Explorer-Optional-amd64'
  )
}

if ($features.disable) {
  Disable-WindowsOptionalFeature -FeatureName $features.disable -Online -NoRestart | Out-Null
}
Enable-WindowsOptionalFeature -FeatureName $features.enable -Online -All -NoRestart | Out-Null
