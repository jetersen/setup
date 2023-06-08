# Install WSL Kernel Patch
$file = "$ENV:TEMP\wsl_update_x64.msi"
curl.exe -sSfL https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -o "$file"
msiexec /a "$file" /passive

wsl --set-default-version 2
if (!(Get-Command "ubuntu.exe" -ErrorAction SilentlyContinue)) {
  winget install --exact --silent "Canonical.Ubuntu.2204"
  ubuntu.exe install --root
  Ubuntu.exe run "curl -sL '$helperUri/WSL.sh' | bash"
  Ubuntu.exe config --default-user joseph
}
