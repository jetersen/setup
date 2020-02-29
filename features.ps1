# install all hyper-v related things
$hypervFeatures = @(Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V* | Select-Object -ExpandProperty FeatureName)

$features = @{
  enable = @(
    'Microsoft-Windows-Subsystem-Linux',
    'VirtualMachinePlatform',
    'Containers'
  ) + $hypervFeatures
  disable = @(
    # Internet Explorer 🤮
    'Internet-Explorer-Optional-amd64'
  )
}

Disable-WindowsOptionalFeature -FeatureName $features.disable -Online -NoRestart
Enable-WindowsOptionalFeature -FeatureName $features.enable -Online -All -NoRestart
