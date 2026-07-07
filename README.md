# WindowsHardening
Run it as administrator!

```
powershell -ep b -nop -c "$w=(New-Object Net.WebClient);IEX $w.DownloadString('https://raw.githubusercontent.com/afkfr0mkeyb0ard/WindowsHardening/refs/heads/main/harden.ps1');"
```

## Windows Hardening Impact Assessment (Sorted by Impact)

### Low Impact Changes

| Hardening Parameter | Potential Impact | Recommendation |
|---|---|---|
| Disable Microsoft Store | Prevents users from installing apps from Microsoft Store | Recommended for corporate environments |
| Disable Windows Telemetry | Reduces diagnostic data collection sent to Microsoft | Recommended |
| Disable Windows Error Reporting | Prevents automatic crash reports from being sent | Recommended in restricted environments |
| Disable Location Services | Applications cannot use device location | Recommended unless location-based apps are required |
| Block Microsoft Accounts | Prevents personal Microsoft account usage | Recommended for domain-joined devices |
| Disable Windows Search Web Search | Removes Bing/web results from Windows Search | Recommended |
| Disable WPAD | Automatic proxy discovery disabled | Recommended to prevent WPAD attacks |
| Disable SMB Compression | Minor performance impact on SMB transfers | Recommended |
| Disable SMBv1 | Legacy SMB applications may stop working | Strongly recommended |
| Disable AutoRun / AutoPlay | USB media will no longer automatically execute content | Recommended |
| Disable Remote Registry | Remote registry administration tools stop working | Recommended |
| Disable PowerShell v2 | Legacy PowerShell scripts may fail | Recommended |
| Disable Consumer Experience | Removes Microsoft suggestions and promoted apps | Recommended |
| Disable Advertising ID | Personalized advertising disabled | Recommended |
| Disable Tailored Experiences | Personalized Windows recommendations disabled | Recommended |
| Disable Activity History | Timeline and activity sync disabled | Recommended |
| Disable Clipboard Cloud Sync | Clipboard synchronization between devices disabled | Recommended |
| Disable Cortana | Voice assistant features unavailable | Recommended |
| Disable Widgets | Windows widgets unavailable | Recommended for enterprise |
| Disable Copilot | AI assistant unavailable | Recommended depending on policy |
| Disable SSDP Discovery | UPnP device discovery disabled | Recommended |
| Disable UPnP Device Host | Automatic device discovery disabled | Recommended |
| Disable DiagTrack Service | Windows telemetry service disabled | Recommended |
| Enable LSA Protection (RunAsPPL) | Some unsigned security software may fail | Recommended |
| Disable WDigest | Legacy authentication compatibility reduced | Recommended |
| Disable NTLMv1 | Very old systems may fail authentication | Strongly recommended |
| Require NTLMv2 | Legacy devices may fail authentication | Recommended |
| Disable Weak Ciphers (RC4/3DES) | Legacy encryption compatibility reduced | Recommended |
| Enable PowerShell Script Block Logging | Increased event log volume | Recommended |
| Enable PowerShell Module Logging | Increased event log volume | Recommended |
| Enable Process Creation Auditing | Increased Security Event Log size | Recommended |
| Enforce UAC | Users receive more elevation prompts | Recommended |

---

### Medium Impact Changes

| Hardening Parameter | Potential Impact | Recommendation |
|---|---|---|
| Disable OneDrive | Prevents OneDrive synchronization and cloud file access | Validate before deployment |
| Disable SMB Guest Logons | Legacy NAS devices and unauthenticated shares may stop working | Recommended |
| Disable Internet Connection Sharing | Users cannot share network connections | Recommended on managed devices |
| Disable Delivery Optimization | Windows updates consume more WAN bandwidth | Validate in large environments |
| Disable WebClient | WebDAV/SharePoint mapped drives may stop working | Validate |
| Enable SMB Signing | Slight SMB performance overhead | Recommended |
| Disable TLS 1.0 | Old applications may lose HTTPS compatibility | Recommended |
| Disable TLS 1.1 | Old applications may lose HTTPS compatibility | Recommended |
| Enable Defender ASR Rules | Some legitimate applications/macros may be blocked | Deploy in Audit Mode first |
| Enable Credential Guard | Some authentication scenarios may require testing | Recommended on compatible hardware |
| Enable HVCI / Memory Integrity | Some drivers may become incompatible | Recommended after validation |
| Enable Controlled Folder Access | Applications may require exclusions | Recommended with tuning |

---

### High Impact Changes

| Hardening Parameter | Potential Impact | Recommendation |
|---|---|---|
| Disable Windows Script Host | VBS/JS scripts and some legacy installers may fail | Enable only if unused |
| Disable WinRM | Breaks PowerShell Remoting and some management tools | Only disable if unused |
| Disable RDP | Remote Desktop access disabled | Only disable if unused |
| Disable Print Spooler | Printing unavailable | Only disable on systems without printers |
