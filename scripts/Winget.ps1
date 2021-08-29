$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"1.10.0.0") {
  "Installing winget Dependencies"
  Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'

  $releases = Invoke-RestMethod "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
  $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('msixbundle') } | Select-Object -First 1 -ExpandProperty browser_download_url

  "Installing winget from ${latestRelease}"
  Add-AppxPackage -Path $latestRelease
  RefreshEnv
}
else {
  "winget already installed"
}
