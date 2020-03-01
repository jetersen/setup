Write-Host "Installing Docker 🐳"
choco install -y Containers --source="'windowsfeatures'"
RefreshEnv
choco install -y docker-desktop
choco install -y docker-compose
