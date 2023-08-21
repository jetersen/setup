winget source update
$PackageIdentifiers = @(
  "Bitwarden.Bitwarden"
  "Flameshot.Flameshot"
  "gerardog.gsudo"
  "Microsoft.Edge"
  "Microsoft.PowerShell"
  "Microsoft.WindowsTerminal"
  "JanDeDobbeleer.OhMyPosh"
  "OlegDanilov.RapidEnvironmentEditor"
  "Parsec.Parsec"
  "SlackTechnologies.Slack"
  "Spotify.Spotify"
  "Yubico.Authenticator"
  "Google.GoogleDrive"
  "OpenVPNTechnologies.OpenVPNConnect"
  "UderzoSoftware.SpaceSniffer"
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
