$taskName = "InstallWSLDistro"
$task = Get-ScheduledTask | Where-Object TaskName -eq $taskName

if ($task) {
  $file = "$env:TEMP\ubuntu-1804.appx"
  Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile $file -UseBasicParsing
  Add-AppxPackage $file
  Remove-Item $file
  $task | Unregister-ScheduledTask -Confirm:$false
} else {
  $scriptlocation = Get-ChildItem .\wsldistro.ps1 | Select-Object -ExpandProperty FullName
  $TaskTrigger = (New-ScheduledTaskTrigger -AtLogOn)
  $TaskAction = New-ScheduledTaskAction -Execute pwsh.exe -argument "$scriptlocation"
  $TaskUserID = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -RunLevel Highest
  Register-ScheduledTask -Force -TaskName $taskName -Action $TaskAction -Principal $TaskUserID -Trigger $TaskTrigger
}
