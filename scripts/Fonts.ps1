$nerdFontsfolder = "${ENV:TEMP}\nerdfonts"
if ([System.IO.Directory]::Exists($folder) -eq $false) {
  New-Item -Path "${nerdFontsfolder}" -ItemType Directory | Out-Null
  $releases = Invoke-RestMethod 'https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest'
  $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('JetBrainsMono.zip') } | Select-Object -First 1 -ExpandProperty browser_download_url
  $zipFile = "${nerdFontsfolder}\nerdfonts.zip"
  curl.exe -sSfL -o "${zipFile}" "${latestRelease}"

  Expand-Archive -Path $zipFile -DestinationPath ${nerdFontsfolder}
}

$systemFonts = @(Get-ChildItem "${ENV:WINDIR}\Fonts" | Where-Object {$_.PSIsContainer -eq $false} | Select-Object -ExpandProperty BaseName)
$userFonts = @(Get-ChildItem "${ENV:LOCALAPPDATA}\Microsoft\Windows\Fonts" -ErrorAction SilentlyContinue | Where-Object {$_.PSIsContainer -eq $false} | Select-Object -ExpandProperty BaseName)
$installedFonts = -join $($systemFonts + $userFonts)
$jetbrainsMonoNFs = @(Get-ChildItem "$nerdFontsfolder\JetBrainsMonoNerdFont*.ttf" -Recurse | Where-Object { $installedFonts -inotlike "*$($_.BaseName)*" })

$jetbainsFolder = "${ENV:TEMP}\jetbrainsmono"
if ([System.IO.Directory]::Exists($jetbainsFolder) -eq $false) {
  New-Item -Path "${jetbainsFolder}" -ItemType Directory | Out-Null
  $releases = Invoke-RestMethod 'https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest'
  $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('zip') } | Select-Object -First 1 -ExpandProperty browser_download_url
  $zipFile = "${jetbainsFolder}\jetbrainsmono.zip"
  curl.exe -sSfL -o $zipFile $latestRelease

  Expand-Archive -Path $zipFile -DestinationPath ${jetbainsFolder}
}

$jetbrainsMonos = @(Get-ChildItem "${jetbainsFolder}\fonts\ttf\JetBrainsMono-*.ttf" -Recurse | Where-Object { $installedFonts -inotlike "*$($_.BaseName)*" })

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

Remove-Item $nerdFontsfolder -Recurse -Force
Remove-Item $jetbainsFolder -Recurse -Force
