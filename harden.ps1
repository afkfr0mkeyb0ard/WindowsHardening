#Prevent null sessions
Write-Host "[+] Disabling null sessions"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymous" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymousSam" -Value 1 -Force

#Disable SMB Guest Logons
Write-Host "[+] Disabling SMB Guest Logons"
Set-SmbServerConfiguration -EnableInsecureGuestLogons $false -Force

#Disable LLMNR
Write-Host "[+] Disabling LLMNR"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT" -Name "DNSClient" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 0 -Force

#Disable mDNS
Write-Host "[+] Disabling mDNS"
if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters")) { New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache" -Name "Parameters" -Force } ;
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "EnableMDNS" -Type DWord -Value 0 -Force

#Disable NBTNS (Netbios over TCP)
Write-Host "[+] Disabling NBTNS"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\tcpip_*' -Name NetbiosOptions -Value 2 -Verbose

#Disable WPAD
Write-Host "[+] Disabling WPAD"
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp")) { New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "WinHttp" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name "DisableWpad" -Type DWord -Value 1 -Force

#Disabling SMBv1
Write-Host "[+] Disabling SMBv1"
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

#Enable SMB Signing
Write-Host "[+] Enabling SMB Signing"
Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $true -Force

#Disable SMB Compression
Write-Host "[+] Disabling SMB Compression"
Set-SmbServerConfiguration -DisableCompression $true -Force

#Prefer IPv4 over IPv6
Write-Host "[+] Prefer IPv4 over IPv6"
if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters")) { New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Force } ;
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Type DWord -Value 32 -Force

#Disable WDigest Credential Storage
Write-Host "[+] Disabling WDigest"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name "UseLogonCredential" -Type DWord -Value 0 -Force

#Disable LM Hash Storage
Write-Host "[+] Disabling LM Hash Storage"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "NoLMHash" -Type DWord -Value 1 -Force

#Enforce NTLMv2
Write-Host "[+] Enforcing NTLMv2"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LmCompatibilityLevel" -Type DWord -Value 5 -Force

#Enable LSA Protection
Write-Host "[+] Enabling LSA Protection"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RunAsPPL" -Type DWord -Value 1 -Force

#Enable Credential Guard
Write-Host "[+] Enabling Credential Guard"
if (-not (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard")) { New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "DeviceGuard" -Force } ;
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LsaCfgFlags" -Type DWord -Value 1 -Force

#Enable UAC Secure Desktop
Write-Host "[+] Enabling UAC Secure Desktop"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 1 -Force

#Disable WinRM
Write-Host "[+] Disabling WinRM"
Stop-Service WinRM -Force -ErrorAction SilentlyContinue
Set-Service WinRM -StartupType Disabled

#Disable RDP
Write-Host "[+] Disabling Remote Desktop"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 1 -Force

#Disable Print Spooler
Write-Host "[+] Disabling Print Spooler"
Stop-Service Spooler -Force -ErrorAction SilentlyContinue
Set-Service Spooler -StartupType Disabled

#Disable WebClient (WebDAV)
Write-Host "[+] Disabling WebClient"
Stop-Service WebClient -Force -ErrorAction SilentlyContinue
Set-Service WebClient -StartupType Disabled

#Disable SSDP Discovery
Write-Host "[+] Disabling SSDP Discovery"
Stop-Service SSDPSRV -Force -ErrorAction SilentlyContinue
Set-Service SSDPSRV -StartupType Disabled

#Disable UPnP Device Host
Write-Host "[+] Disabling UPnP Device Host"
Stop-Service upnphost -Force -ErrorAction SilentlyContinue
Set-Service upnphost -StartupType Disabled

#Disable AutoRun / AutoPlay
Write-Host "[+] Disabling AutoRun"
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) { New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies" -Name "Explorer" -Force }
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 255 -Force

#Disable Remote Assistance
Write-Host "[+] Disabling Remote Assistance"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0 -Force

#Disable Windows Script Host
Write-Host "[+] Disabling Windows Script Host"
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings")) { New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host" -Name "Settings" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -Type DWord -Value 0 -Force

#Disable PowerShell v2
Write-Host "[+] Disabling PowerShell v2"
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root -NoRestart

#Disable Internet Connection Sharing
Write-Host "[+] Disabling Internet Connection Sharing"
Stop-Service SharedAccess -Force -ErrorAction SilentlyContinue
Set-Service SharedAccess -StartupType Disabled

#Disable Windows Diagnostics / Telemetry
Write-Host "[+] Disabling Windows Diagnostics and Telemetry"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "DataCollection" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0 -Force

#Disable Connected User Experiences and Telemetry
Write-Host "[+] Disabling DiagTrack"
Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
Set-Service DiagTrack -StartupType Disabled

#Disable Windows Error Reporting
Write-Host "[+] Disabling Windows Error Reporting"
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting")) { New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows" -Name "Windows Error Reporting" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "AutoApproveOSDumps" -Type DWord -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "DontSendAdditionalData" -Type DWord -Value 1 -Force
Stop-Service WerSvc -Force -ErrorAction SilentlyContinue
Set-Service WerSvc -StartupType Disabled

#Disable WindowsStore
Write-Host "[+] Disabling Windows Store"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "WindowsStore" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "RemoveWindowsStore" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "DisableStoreApps" -Type DWord -Value 1 -Force

#Disable Location Services
Write-Host "[+] Disabling Location Services"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "LocationAndSensors" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Type DWord -Value 1 -Force
Stop-Service lfsvc -Force -ErrorAction SilentlyContinue
Set-Service lfsvc -StartupType Disabled

#Block Microsoft Accounts
Write-Host "[+] Blocking Microsoft Accounts"
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")) { New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies" -Name "System" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoConnectedUser" -Type DWord -Value 3 -Force

#Disable Windows Search Web Search
Write-Host "[+] Disabling Windows Search Web Search"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Windows Search" -Force }
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -Type DWord -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWebOverMeteredConnections" -Type DWord -Value 0 -Force

#Disable OneDrive
Write-Host "[+] Disabling OneDrive"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "OneDrive" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1 -Force
Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue

#Disable Consumer Experience
Write-Host "[+] Disabling Windows Consumer Experience"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "CloudContent" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1 -Force

#Disable Advertising ID
Write-Host "[+] Disabling Advertising ID"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "AdvertisingInfo" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1 -Force

#Disable Tailored Experiences
Write-Host "[+] Disabling Tailored Experiences"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "CloudContent" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1 -Force

#Disable Delivery Optimization
Write-Host "[+] Disabling Delivery Optimization"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "DeliveryOptimization" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 100 -Force

#Disable Cortana
Write-Host "[+] Disabling Cortana"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Windows Search" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0 -Force

#Disable Widgets
Write-Host "[+] Disabling Widgets"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "Dsh" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Type DWord -Value 0 -Force

#Disable Copilot
Write-Host "[+] Disabling Copilot"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "WindowsCopilot" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Type DWord -Value 1 -Force

#Disable Windows Recall
Write-Host "[+] Disabling Windows Recall"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "WindowsAI" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" -Name "DisableAIDataAnalysis" -Type DWord -Value 1 -Force

#Disable GameDVR and Xbox Game Recording
Write-Host "[+] Disabling GameDVR and Xbox Game Recording"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "GameDVR" -Force } ; 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Type DWord -Value 0 -Force
if (-not (Test-Path "HKCU:\System\GameConfigStore")) { New-Item -Path "HKCU:\System" -Name "GameConfigStore" -Force } ; Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0 -Force

#Disable Xbox Services
Write-Host "[+] Disabling Xbox Services"
Get-Service -Name XboxGipSvc,XblAuthManager,XblGameSave,XboxNetApiSvc -ErrorAction SilentlyContinue | Stop-Service -Force -ErrorAction SilentlyContinue
Get-Service -Name XboxGipSvc,XblAuthManager,XblGameSave,XboxNetApiSvc -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled

#Disable Feedback Hub
Write-Host "[+] Disabling Feedback Hub"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "DataCollection" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1 -Force

#Disable Windows Tips and Suggestions
Write-Host "[+] Disabling Windows Tips and Suggestions"
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) { New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "CloudContent" -Force } ;
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableSoftLanding" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightFeatures" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightOnActionCenter" -Type DWord -Value 1 -Force

#Enable Microsoft Defender ASR Rule - Block Office Child Process Creation
Write-Host "[+] Enabling Defender ASR Rule - Office Child Process Creation"
Add-MpPreference -AttackSurfaceReductionRules_Ids "d4f940ab-401b-4efc-aadc-ad5f3c50688a" -AttackSurfaceReductionRules_Actions Enabled

#Enable Microsoft Defender ASR Rule - Block Credential Stealing From LSASS
Write-Host "[+] Enabling Defender ASR Rule - LSASS Credential Protection"
Add-MpPreference -AttackSurfaceReductionRules_Ids "9e6c4e1f-7d60-472f-ba1a-a39ef669e4f2" -AttackSurfaceReductionRules_Actions Enabled

#Enable Microsoft Defender ASR Rule - Block Executable Content From Email and Webmail
Write-Host "[+] Enabling Defender ASR Rule - Email/Web Executables"
Add-MpPreference -AttackSurfaceReductionRules_Ids "be9ba2d9-53ea-4cdc-84e5-9b1eeee46550" -AttackSurfaceReductionRules_Actions Enabled

#Enable Microsoft Defender ASR Rule - Block Executables From USB
Write-Host "[+] Enabling Defender ASR Rule - USB Executables"
Add-MpPreference -AttackSurfaceReductionRules_Ids "b2b3f03d-6a65-4f7b-a9c7-1c7ef74f7c8d" -AttackSurfaceReductionRules_Actions Enabled
