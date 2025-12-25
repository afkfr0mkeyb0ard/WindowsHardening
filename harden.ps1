#Disable LLMNR
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT" -Name "DNSClient" -Force } ; Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 0 -Force

#Disable mDNS
if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\EnableMDNS")) { New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "EnableMDNS" -Force } ; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "EnableMDNS" -Value 0 -Force

#Disable NBTNS (Netbios over TCP)
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\tcpip_*' -Name NetbiosOptions -Value 2 -Verbose
