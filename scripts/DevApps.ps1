winget source update
$PackageIdentifiers = @(
  "Git.Git"
  "GitHub.cli"
  "GitHub.GitHubDesktop"
  "JetBrains.Toolbox"
  "Microsoft.DotNet.SDK.7"
  "Microsoft.DotNet.SDK.Preview"
  "Microsoft.VisualStudioCode"
  "Mirantis.Lens"
  "SecretsOPerationS.SOPS"
  "WinSCP.WinSCP"
  "Amazon.AWSCli"
  "Google.CloudSDK"
  "dandavison.delta"
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
