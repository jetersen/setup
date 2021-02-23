choco install git -params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration /SChannel"'
choco install `
  bitwarden-cli `
  maven `
  gpg4win `
  gsudo `
  rapidee `
  microsoft-teams.install `
  jetbrainstoolbox `
  microsoft-windows-terminal `
  element-desktop `
  keybase `


choco install
  nuget.commandline `
  gh `
  7zip `
  vscode `
  pwsh `
  git `
  gsudo `
  heidisql `


choco install
  dotnet-sdk `
  docker-desktop `
  googlechrome `
  firefox `
  sops `
  spacesniffer `
  spotify `
  winscp `


choco install AdoptOpenJDK11 --params="/ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome /INSTALLDIR=C:\Program Files\AdoptOpenJDK\jdk11"
choco install AdoptOpenJDK8 --params="/ADDLOCAL=FeatureMain,FeatureEnvironment /INSTALLDIR=C:\Program Files\AdoptOpenJDK\jdk8"

RefreshEnv

gsudo config CacheMode Auto

$extensions = @(
  'dbaeumer.vscode-eslint'
  'eamodio.gitlens'
  'EditorConfig.EditorConfig'
  'file-icons.file-icons'
  'hashicorp.terraform'
  'ionutvmi.reg' # windows registry files
  'mitchdenny.ecdc' # encode decode
  'ms-azuretools.vscode-docker'
  'ms-python.python'
  'ms-vscode-remote.remote-ssh'
  'ms-vscode-remote.remote-ssh-edit'
  'ms-vscode-remote.remote-wsl'
  'ms-vscode.powershell'
  'ms-vsliveshare.vsliveshare'
  'oderwat.indent-rainbow'
  'redhat.vscode-xml'
  'redhat.vscode-yaml'
  'rust-lang.rust'
  'yzhang.markdown-all-in-one'
)
$extensions = $extensions | Foreach-Object { "--install-extension $_" }

Invoke-Expression "code $extensions"
