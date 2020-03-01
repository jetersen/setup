choco install -y powershell-preview

RefreshEnv

$env:Path += ";C:\Program Files\PowerShell\7-preview"

[Environment]::SetEnvironmentVariable("Path", $env:Path, "Machine")
