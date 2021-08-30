$folder = "${ENV:TEMP}\nerdfonts"
if ([System.IO.Directory]::Exists($folder) -eq $false) {
  New-Item -Path "${folder}" -ItemType Directory | Out-Null
  git clone --depth 1 --filter=blob:none --sparse 'https://github.com/ryanoasis/nerd-fonts.git' "${folder}"
}

$systemFonts = @(Get-ChildItem "${ENV:WINDIR}\Fonts" | Where-Object {$_.PSIsContainer -eq $false} | Select-Object -ExpandProperty BaseName)
$userFonts = @(Get-ChildItem "${ENV:LOCALAPPDATA}\Microsoft\Windows\Fonts" -ErrorAction SilentlyContinue | Where-Object {$_.PSIsContainer -eq $false} | Select-Object -ExpandProperty BaseName)
$installedFonts = -join $($systemFonts + $userFonts)
$fontsDir = "patched-fonts/JetBrainsMono/Ligatures"
Push-Location "$folder"
git sparse-checkout set "$fontsDir"
$jetbrainsMonoNFs = @(Get-ChildItem "*Complete Windows Compatible.ttf" -Recurse | Where-Object { $installedFonts -inotlike "*$($_.BaseName)*" })

Pop-Location

$folder = "${ENV:TEMP}\jetbrainsmono"
if ([System.IO.Directory]::Exists($folder) -eq $false) {
  $releases = Invoke-RestMethod 'https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest'
  $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('zip') } | Select-Object -First 1 -ExpandProperty browser_download_url
  $zipFile = "${ENV:TEMP}\jetbrainsmono.zip"
  curl.exe -sSfL -o "${zipFile}" "${latestRelease}"

  Expand-Archive -Path "${zipFile}" -DestinationPath "${folder}"
}

$jetbrainsMonos = @(Get-ChildItem "${folder}\fonts\ttf\JetBrainsMono-*.ttf" -Recurse | Where-Object { $installedFonts -inotlike "*$($_.BaseName)*" })

$fontFiles = $jetbrainsMonoNFs + $jetbrainsMonos

if ($fontFiles) {
  $installDir = "./installPlease"
  $installDirItem = New-Item $installDir -ItemType Directory -Force

  $fontFiles | Copy-Item -Force -Destination $installDirItem

  $shellApp = New-Object -ComObject shell.application
  $installingFonts = $shellApp.NameSpace("$($installDirItem.FullName)")
  $fonts = $shellApp.NameSpace(0x14)
  $fonts.CopyHere($installingFonts.Items())
  if ([System.IO.Directory]::Exists($installDir)) {
    Remove-Item $installDir -Recurse -Force
  }
}
