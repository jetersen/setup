Write-Host "Installing Docker 🐳"
choco install -y Containers -source WindowsFeatures
RefreshEnv
choco install -y docker-desktop
choco install -y docker-compose
