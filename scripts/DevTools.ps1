Write-Host "Installing DevTools"
choco install -y dotnetcore-sdk --version=2.1.805 --side-by-side
choco install -y dotnetcore-sdk --version=3.1.201 --side-by-side
choco install -y netfx-4.8-devpack
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration /SChannel"'
choco install -y python3
choco install -y adoptopenjdk11
choco install -y adoptopenjdk8
choco install -y maven
choco install -y gpg4win
choco install -y gsudo
choco install -y hub
choco install -y jetbrainsmono
choco install -y rapidee
choco install -y slack
choco install -y jetbrainstoolbox
choco install -y microsoft-windows-terminal
