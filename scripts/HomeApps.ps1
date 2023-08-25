winget source update
$PackageIdentifiers = @(
  "Valve.Steam"
  "Nvidia.Broadcast"
  "Elgato.StreamDeck"
  "Elgato.ControlCenter"
  "Voicemod.Voicemod"
)

$wingetList = winget list --accept-source-agreements
foreach ($package in $PackageIdentifiers) {
  if ($wingetList | Select-String -Pattern $package.Replace('+', '\+') -Quiet) {
    "$package already installed"
  } else {
    "Installing $package"
    winget install --exact $package --accept-package-agreements
  }
}
