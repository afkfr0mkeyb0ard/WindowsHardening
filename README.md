# WindowsHardening
Run it as administrator!

```
powershell -ep b -nop -c "$w=(New-Object Net.WebClient);IEX $w.DownloadString('https://raw.githubusercontent.com/afkfr0mkeyb0ard/WindowsHardening/refs/heads/main/harden.ps1');"
```

## Windows Hardening Impact Assessment (Sorted by Impact)

| Impact | Modification | Possible impact / side effects |
|---|---|---|
| 🔴 High | Disable Microsoft Accounts | Prevents the use of personal Microsoft accounts. May affect Microsoft Store, synchronization, and some Windows 11 features. |
| 🔴 High | Disable IPv6 (`DisabledComponents=32`) | May break modern environments using IPv6, Entra ID/Azure AD scenarios, DirectAccess, or applications relying on IPv6. Prefer IPv4 preference instead of full disablement. |
| 🔴 High | Disable Windows Store | Prevents Microsoft Store applications installation and updates. Some modern Windows applications may be affected. |
| 🔴 High | Enable LSA Protection (`RunAsPPL`) | May cause compatibility issues with older security software, credential providers, or legacy drivers. |
| 🔴 High | Enable Credential Guard | May break legacy authentication scenarios, NTLM-dependent applications, VPN clients, or credential delegation workflows. |
| 🔴 High | Disable WinRM | Removes remote PowerShell administration and Windows Remote Management capabilities. |
| 🔴 High | Disable Remote Desktop | Prevents incoming RDP connections. |
| 🔴 High | Disable Print Spooler | Prevents local and network printing functionality. |
| 🔴 High | Enable SMB Signing | Can impact performance and compatibility with legacy NAS devices or older SMB implementations. |
| 🟠 Medium-High | Disable NTLMv1 (`LmCompatibilityLevel=5`) | May break legacy applications or systems requiring NTLMv1 authentication. |
| 🟠 Medium-High | Disable SMB Guest Logons | Prevents access to anonymous SMB shares and some legacy NAS configurations. |
| 🟠 Medium-High | Disable SMB Compression | May reduce SMB transfer performance on large file operations. |
| 🟠 Medium | Disable PowerShell v2 | Legacy PowerShell v2 scripts and tools will no longer work. |
| 🟠 Medium | Disable Windows Script Host | Prevents execution of `.vbs` and `.js` scripts using WSH. |
| 🟠 Medium | Disable WebClient (WebDAV) | May break WebDAV-based applications or legacy SharePoint integrations. |
| 🟠 Medium | Disable OneDrive | Prevents OneDrive synchronization for personal and enterprise accounts. |
| 🟠 Medium | Disable Delivery Optimization | Windows updates may consume more bandwidth because peer-to-peer optimization is disabled. |
| 🟠 Medium | Disable Xbox Services / GameDVR | Removes Xbox integration, game recording, and gaming-related features. |
| 🟠 Medium | Disable Widgets | Removes Windows Widgets functionality. |
| 🟠 Medium | Disable Windows Copilot | Removes Copilot integration in Windows. |
| 🟠 Medium | Disable Windows Recall | Disables Recall functionality on compatible Windows 11 devices. |
| 🟠 Medium | Disable Location Services | Applications requiring location data (maps, weather, device location) may stop working correctly. |
| 🟠 Medium | Disable Windows Search Web Search | Windows Search remains available but web results are removed. |
| 🟠 Medium | Disable Windows Consumer Experience | Removes suggested applications and Microsoft promotional content. |
| 🟠 Medium | Disable Windows Spotlight | Removes dynamic wallpapers and Spotlight suggestions. |
| 🟠 Medium | Disable Feedback Hub | Prevents users from submitting feedback to Microsoft. |
| 🟡 Low-Medium | Disable Telemetry (`AllowTelemetry=0`) | Reduces Microsoft diagnostics and may limit troubleshooting capabilities. |
| 🟡 Low-Medium | Disable Connected User Experiences and Telemetry (`DiagTrack`) | Reduces telemetry collection and diagnostic functionality. |
| 🟡 Low-Medium | Disable Windows Error Reporting | Crash information will no longer be automatically sent to Microsoft. |
| 🟡 Low-Medium | Disable AutoRun / AutoPlay | Removable media will require manual interaction instead of automatic execution. |
| 🟡 Low-Medium | Disable SSDP Discovery | UPnP network device discovery may stop working. |
| 🟡 Low-Medium | Disable UPnP Device Host | Some multimedia and IoT devices may no longer be automatically discovered. |
| 🟡 Low-Medium | Disable Internet Connection Sharing | Users cannot share their network connection from the workstation. |
| 🟡 Low-Medium | Disable NBT-NS | May affect legacy environments relying on NetBIOS name resolution. |
| 🟡 Low | Disable LLMNR | No expected impact in modern environments using DNS properly. |
| 🟡 Low | Disable mDNS | May affect Bonjour discovery, AirPrint, Apple devices, or some IoT devices. |
| 🟡 Low | Disable WPAD | May break environments relying on automatic proxy discovery. |
| 🟡 Low | Disable Null Sessions | No expected impact on modern Windows environments. |
| 🟡 Low | Disable LM Hash Storage | No expected impact on modern Windows systems. |
| 🟡 Low | Disable WDigest Credential Storage | No expected impact on modern Windows systems. |
| 🟡 Low | Enforce NTLMv2 | No expected impact except on very old systems. |
| 🟢 Low | Disable Advertising ID | No functional impact. |
| 🟢 Low | Disable Tailored Experiences | Removes personalized Windows recommendations. |
| 🟢 Low | Disable Windows Tips and Suggestions | Removes Windows tips and recommendations. |
| 🟢 Low | Disable Cortana | No meaningful impact on modern Windows versions. |
| 🟢 Low | Disable Windows Error Dump Upload | Reduces automatic diagnostic information sharing. |
| 🟢 Low | Disable Microsoft Store suggestions | Removes promotional Store recommendations. |
| 🟢 Low | Defender ASR - Block Office Child Process Creation | May block legitimate Office automation workflows and macros. |
| 🟢 Low | Defender ASR - Block Credential Stealing From LSASS | Very low compatibility impact, highly recommended. |
| 🟢 Low | Defender ASR - Block Executables From Email/Webmail | May block legitimate downloaded executables. |
| 🟢 Low | Defender ASR - Block Executables From USB | May block portable tools running from removable media. |
