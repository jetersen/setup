choco install maven
choco install sops
choco install spacesniffer

winget source update
$PackageIdentifiers = @(
  "3T.Robo3T"
  "7zip.7zip"
  "Adobe.AdobeAcrobatReaderDC"
  "AdoptOpenJDK.OpenJDK.11"
  "AdoptOpenJDK.OpenJDK.8"
  "Bitwarden.Bitwarden"
  "CPUID.HWMonitor"
  "Docker.DockerDesktop"
  "Element.Element"
  "Elgato.ControlCenter"
  "Elgato.StreamDeck"
  "Flameshot.Flameshot"
  "gerardog.gsudo"
  "Git.Git"
  "GitHub.cli"
  "GitHub.GitHubDesktop"
  "GnuPG.GnuPG"
  "GnuPG.Gpg4win"
  "Google.Chrome"
  "HeidiSQL.HeidiSQL"
  "JanDeDobbeleer.OhMyPosh"
  "JetBrains.Toolbox"
  "Microsoft.dotnet"
  "Microsoft.dotnet"
  "Microsoft.Edge"
  "Microsoft.OneDrive"
  "Microsoft.PowerShell"
  "Microsoft.Teams"
  "Microsoft.VC++2008Redist-x86"
  "Microsoft.VC++2010Redist-x86"
  "Microsoft.VC++2015-2019Redist-x64"
  "Microsoft.VC++2015-2019Redist-x86"
  "Microsoft.VisualStudioCode"
  "Microsoft.WindowsTerminal"
  "Mirantis.Lens"
  "Mozilla.Firefox"
  "mRemoteNG.mRemoteNG"
  "NordVPN.NordVPN"
  "Notepad++.Notepad++"
  "Nvidia.Broadcast"
  "OpenVPNTechnologies.OpenVPNConnect"
  "Parsec.Parsec"
  "Piriform.Speccy"
  "Python.Python.3"
  "SlackTechnologies.Slack"
  "Spotify.Spotify"
  "uw-labs.BloomRPC"
  "Valve.Steam"
  "VideoLAN.VLC"
  "Voicemod.Voicemod"
  "WinSCP.WinSCP"
  "WireGuard.WireGuard"
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
