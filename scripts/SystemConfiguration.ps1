#--- Enable developer mode on the system ---
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock' -Name 'AllowDevelopmentWithoutDevLicense' -Value 1

# enable TLS 1.2 on 64 bit .Net Framework
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v2.0.50727' -Name 'SchUseStrongCrypto' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v2.0.50727' -Name 'SystemDefaultTlsVersions' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value 1

# enable TLS 1.2 on 32 bit .Net Framework
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' -Name 'SchUseStrongCrypto' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727' -Name 'SystemDefaultTlsVersions' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SystemDefaultTlsVersions' -Value 1

# UTF-8!

$CodePageProperties=@{
  ACP=65001
  MACCP=65001
  OEMCP=65001
}

foreach ($Item in $CodePageProperties.Keys)
{
  New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage -Name $Item -PropertyType String -Value $CodePageProperties[$Item] -Force
}
