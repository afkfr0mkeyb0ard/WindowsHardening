# WindowsHardening
Run it as administrator!

```
powershell -ep b -nop -c "$w=(New-Object Net.WebClient);IEX $w.DownloadString('https://raw.githubusercontent.com/afkfr0mkeyb0ard/WindowsHardening/refs/heads/main/harden.ps1');"
```

## Windows Hardening Impact Assessment

| Hardening Parameter | Impact Level | Potential Impact | Recommendation |
|---|---|---|---|
| Disable Microsoft Store | Low | Prevents users from installing apps from Microsoft Store | Recommended for corporate environments |
| Disable Windows Telemetry | Low | Reduces diagnostic data collection sent to Microsoft | Recommended |
| Disable Windows Error Reporting | Low | Prevents automatic crash reports from being sent | Recommended in restricted environments |
| Disable Location Services | Low | Applications cannot use device location | Recommended unless location-based apps are required |
| Block Microsoft Accounts | Low | Prevents personal Microsoft account usage | Recommended for domain-joined devices |
| Disable Windows Search Web Search | Low | Removes Bing/web results from Windows Search | Recommended |
| Disable OneDrive | Medium | Prevents OneDrive synchronization and cloud file access | Validate before deployment |
| Disable WPAD | Low | Automatic proxy discovery disabled | Recommended to prevent WPAD attacks |
| Disable SMB Guest Logons | Medium | Legacy NAS devices and unauthenticated shares may stop working | Recommended |
| Disable SMB Compression | Low | Minor performance impact on SMB transfers | Recommended |
| Disable SMBv1 | Low | Legacy SMB applications may stop working | Strongly recommended |
| Disable AutoRun / AutoPlay | Low | USB media will no longer automatically execute content | Recommended |
| Disable Remote Registry | Low | Remote registry administration tools stop working | Recommended |
| Disable Windows Script Host | High | VBS/JS scripts and some legacy installers may fail | Enable only if unused |
| Disable PowerShell v2 | Low | Legacy PowerShell scripts may fail | Recommended |
| Disable Internet Connection Sharing | Medium | Users cannot share network connections | Recommended on managed devices |
| Disable Consumer Experience | Low | Removes Microsoft suggestions and promoted apps | Recommended |
| Disable Advertising ID | Low | Personalized advertising disabled | Recommended |
| Disable Tailored Experiences | Low | Personalized Windows recommendations disabled | Recommended |
| Disable Activity History | Low | Timeline and activity sync disabled | Recommended |
| Disable Clipboard Cloud Sync | Low | Clipboard synchronization between devices disabled | Recommended |
| Disable Delivery Optimization | Medium | Windows updates consume more WAN bandwidth | Validate in large environments |
| Disable Cortana | Low | Voice assistant features unavailable | Recommended |
| Disable Widgets | Low | Windows widgets unavailable | Recommended for enterprise |
| Disable Copilot | Low | AI assistant unavailable | Recommended depending on policy |
| Disable WinRM | High | Breaks PowerShell Remoting and some management tools | Only disable if unused |
| Disable RDP | High | Remote Desktop access disabled | Only disable if unused |
| Disable Print Spooler | High | Printing unavailable | Only disable on systems without printers |
| Disable WebClient | Medium | WebDAV/SharePoint mapped drives may stop working | Validate |
| Disable SSDP Discovery | Low | UPnP device discovery disabled | Recommended |
| Disable UPnP Device Host | Low | Automatic device discovery disabled | Recommended |
| Disable DiagTrack Service | Low | Windows telemetry service disabled | Recommended |
| Enable LSA Protection | Low | Some unsigned security software may fail | Recommended |
| Disable WDigest | Low | Legacy authentication compatibility reduced | Recommended |
| Disable NTLMv1 | Low | Very old systems may fail authentication | Strongly recommended |
| Require NTLMv2 | Low | Legacy devices may fail authentication | Recommended |
| Enable SMB Signing | Medium | Slight SMB performance overhead | Recommended |
| Disable TLS 1.0 | Medium | Old applications may lose HTTPS compatibility | Recommended |
| Disable TLS 1.1 | Medium | Old applications may lose HTTPS compatibility | Recommended |
| Disable Weak Ciphers (RC4/3DES) | Low | Legacy encryption compatibility reduced | Recommended |
| Enable PowerShell Script Block Logging | Low | Additional event log volume | Recommended |
| Enable PowerShell Module Logging | Low | Additional event log volume | Recommended |
| Enable Process Creation Auditing | Low | Increased Security Event Log size | Recommended |
| Enable Defender ASR Rules | Medium | Some legitimate applications/macros may be blocked | Recommended with audit mode first |
| Enable Credential Guard | Medium | Some authentication scenarios may require testing | Recommended on compatible hardware |
| Enable HVCI / Memory Integrity | Medium | Some drivers may become incompatible | Recommended after validation |
| Enable Controlled Folder Access | Medium | Applications may require exclusions | Recommended with tuning |
| Enforce UAC | Low | Users receive more elevation prompts | Recommended |
