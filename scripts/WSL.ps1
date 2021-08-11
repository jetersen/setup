$winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')
if ($winVer -ge 2004) {
  RefreshEnv
  # wsl 2 rocks 🚀
  wsl --set-default-version 2
}
if (!(Get-Command "ubuntu2004.exe" -ErrorAction SilentlyContinue)) {
  choco install wsl-ubuntu-2004 --params "/InstallRoot:true"

  RefreshEnv
  Ubuntu2004 run "curl -sL '$helperUri/WSL.sh' | bash"
  Ubuntu2004 config --default-user joseph
}
