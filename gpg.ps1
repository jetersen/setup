param (
  [string]
   $path = './private_keys.pgp'
)
if (!(Get-Command "gpg.exe" -ErrorAction SilentlyContinue)) {
  $env:PATH += ";$(scoop prefix gpg4win)\GnuPG\bin"
}

gpg --import $path
Write-Output "trust`n5`ny`n" | gpg --command-fd 0 --edit-key DC9B38AD2000D95F
Write-Output "trust`n5`ny`n" | gpg --command-fd 0 --edit-key C4840AF1BB43C93F
