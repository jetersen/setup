choco install sops
choco install spacesniffer

winget source update
$PackageIdentifiers = @(
  "7zip.7zip"
  "Bitwarden.Bitwarden"
  "Docker.DockerDesktop"
  "Flameshot.Flameshot"
  "gerardog.gsudo"
  "Git.Git"
  "GitHub.cli"
  "GitHub.GitHubDesktop"
  "JanDeDobbeleer.OhMyPosh"
  "JetBrains.Toolbox"
  "Microsoft.dotnet"
  "Microsoft.Edge"
  "Microsoft.PowerShell"
  "Microsoft.VisualStudioCode"
  "Microsoft.WindowsTerminal"
  "Mirantis.Lens"
  "OlegDanilov.RapidEnvironmentEditor"
  "Parsec.Parsec"
  "SlackTechnologies.Slack"
  "Spotify.Spotify"
  "WinSCP.WinSCP"
  "Yubico.Authenticator"
  "Zoom.Zoom"
)

$wingetList = winget list
foreach ($package in $PackageIdentifiers) {
  if ($wingetList | Select-String -Pattern $package.Replace('+', '\+') -Quiet) {
    "$package already installed"
  } else {
    winget install --exact --silent $package
  }
}

Update-SessionEnvironment
