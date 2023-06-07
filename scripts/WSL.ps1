# Install WSL Kernel Patch
$file = "$ENV:TEMP\wsl_update_x64.msi"
curl.exe -sSfL https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -o "$file"
msiexec /a "$file" /passive

wsl --set-default-version 2
if (!(Get-Command "ubuntu2004.exe" -ErrorAction SilentlyContinue)) {
  winget install --exact --silent "Canonical.Ubuntu.2204"
  ubuntu2204.exe install --root
  Ubuntu2204 run "curl -sL '$helperUri/WSL.sh' | bash"
  Ubuntu2204 config --default-user joseph
}
