choco install git -params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration /SChannel"'
choco install dotnetcore-sdk `
  adoptopenjdk11 `
  adoptopenjdk8 `
  maven `
  gpg4win `
  gsudo `
  hub `
  rapidee `
  microsoft-teams.install `
  slack `
  jetbrainstoolbox `
  microsoft-windows-terminal `
  keybase `
  gh `
  hub `
  7zip `
  vscode `
  pwsh `
  docker-desktop `
  docker-compose `
  googlechrome `
  firefox `


RefreshEnv

gsudo config CacheMode Auto

$extensions = @(
  'dbaeumer.vscode-eslint',
  'eamodio.gitlens',
  'EditorConfig.EditorConfig',
  'file-icons.file-icons',
  'hashicorp.terraform',
  'ionutvmi.reg', # windows registry files
  'mitchdenny.ecdc', # encode decode
  'ms-azuretools.vscode-docker',
  'ms-python.python',
  'ms-vscode-remote.remote-ssh',
  'ms-vscode-remote.remote-ssh-edit',
  'ms-vscode-remote.remote-wsl',
  'ms-vscode.powershell',
  'ms-vsliveshare.vsliveshare',
  'oderwat.indent-rainbow',
  'redhat.vscode-xml',
  'redhat.vscode-yaml',
  'rust-lang.rust',
  'yzhang.markdown-all-in-one'
)
$extensions = $extensions | Foreach-Object { "--install-extension $_" }

Invoke-Expression "code $extensions"
