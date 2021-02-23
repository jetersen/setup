choco install git -params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration /SChannel"'
choco install bitwarden-cli
choco install maven
choco install gpg4win
choco install gsudo
choco install rapidee
choco install microsoft-teams.install
choco install jetbrainstoolbox
choco install microsoft-windows-terminal
choco install nuget.commandline
choco install gh
choco install 7zip
choco install vscode
choco install pwsh
choco install git
choco install heidisql
choco install keybase
choco install dotnet-sdk
choco install docker-desktop
choco install googlechrome
choco install firefox
choco install sops
choco install spacesniffer
choco install spotify
choco install winscp
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
