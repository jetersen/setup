Write-Host "Installing DevTools"
choco install -y dotnetcore-sdk
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration /SChannel"'
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

# UTF-8!

$CodePageProperties=@{
  ACP=65001
  MACCP=65001
  OEMCP=65001
}

foreach ($Item in $CodePageProperties.Keys)
{
  New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage -Name $Item -PropertyType String -Value $CodePageProperties[$Item] -Force
}
