Write-Host "Installing VSCode and co"
choco install -y vscode
RefreshEnv
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
