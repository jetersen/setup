wsl --set-default-version 2
if (!(Get-Command "ubuntu2004.exe" -ErrorAction SilentlyContinue)) {
  winget install --exact --silent "Canonical.Ubuntu.2004"
  ubuntu2004.exe install --root
  Ubuntu2004 run "curl -sL '$helperUri/WSL.sh' | bash"
  Ubuntu2004 config --default-user joseph
}
