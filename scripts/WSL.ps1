$winVer = [int](Get-Item "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseID')
if ($winVer -ge 2004) {
  RefreshEnv
  # wsl 2 rocks 🚀
  wsl --set-default-version 2
}
if (!(Get-Command "ubuntu2004.exe" -ErrorAction SilentlyContinue)) {
  $item = "wslubuntu2004"
  $file = "$env:TEMP\$item.appx"
  Write-Host "Downloading $item"
  curl.exe -sL https://aka.ms/$item -o $file
  Add-AppxPackage $file
  Remove-Item $file

  RefreshEnv

  Ubuntu2004 install --root
  Ubuntu2004 config --default-user root
  Ubuntu2004 run "curl -sL '$helperUri/WSL.sh' | bash"
  Ubuntu2004 run passwd joseph
  Ubuntu2004 config --default-user joseph
}
