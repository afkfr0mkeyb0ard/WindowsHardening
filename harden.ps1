#Prevent null sessions
Write-Host "[+] Disabling null sessions"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymous" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymousSam" -Value 1 -Force

#Disable LLMNR
Write-Host "[+] Disabling LLMNR"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT" -Name "DNSClient" -Force } ; Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 0 -Force

#Disable mDNS
Write-Host "[+] Disabling mDNS"
if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\EnableMDNS")) { New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "EnableMDNS" -Force } ; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "EnableMDNS" -Value 0 -Force

#Disable NBTNS (Netbios over TCP)
Write-Host "[+] Disabling NBTNS"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\tcpip_*' -Name NetbiosOptions -Value 2 -Verbose

#Disabling SMBv1
Write-Host "[+] Disabling SMBv1"
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
