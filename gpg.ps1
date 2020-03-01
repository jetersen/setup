param (
  [string]
   $path = './private_keys.pgp'
)
# TODO: Figure out where to download private keys from

if (Test-Path $path && get-command gpg -ErrorAction SilentlyContinue) {
  gpg --import $path
  Write-Output "trust`n5`ny`n" | gpg --command-fd 0 --edit-key DC9B38AD2000D95F
  Write-Output "trust`n5`ny`n" | gpg --command-fd 0 --edit-key C4840AF1BB43C93F
}
