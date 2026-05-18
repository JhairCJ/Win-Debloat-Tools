# AGENTS.md - Win-Debloat-Tools Project Guide

## 📋 Project Overview

**Win-Debloat-Tools** is a PowerShell-based Windows optimization and debloating suite that reimagines Windows like a minimal OS install with minimal functionality impact.

### Key Purpose
- Remove unnecessary bloatware and services from Windows 10/11
- Optimize performance, privacy, and security
- Provide both GUI and CLI interfaces for different user preferences
- Enable full rollback/restoration of changes
- Support system repairs and maintenance

### Supported Versions
- Windows 10/11 (24H2 or older)
- Home and Pro editions
- x86/x64 architecture only (ARM/ARM64 will break installation)
- PowerShell v5.1+

---

## 🏗️ Project Structure

### Root Level Files
- **WinDebloatTools.ps1** - Main entry point (GUI/CLI mode selector)
- **OpenTerminalHere.cmd** - Quick launcher for administrator terminal
- **README.md** - User documentation
- **ROADMAP.md** - Development history and planned features
- **CONTRIBUTING.md** - Contribution guidelines
- **LICENSE.txt** - Project license

### `/src/lib/` - Core Libraries & Modules

#### Main Utilities
- **Get-HardwareInfo.psm1** - Retrieves system hardware specifications
- **Get-TempScriptFolder.psm1** - Manages temporary script folders
- **Install-Font.psm1** - Font installation helper
- **New-Shortcut.psm1** - Windows shortcut creation
- **Open-File.psm1** - File browser/selection utilities
- **Request-FileDownload.psm1** - Web file downloading with validation
- **Set-ConsoleStyle.psm1** - Console color/styling management
- **Set-RevertStatus.psm1** - Tracks and manages revert/undo operations
- **Start-Logging.psm1** - Logging system (outputs to `C:\Users\<USERNAME>\AppData\Local\Temp\Win-DT-Logs`)
- **Title-Templates.psm1** - Console window title formatting
- **Unregister-DuplicatedPowerPlan.psm1** - Power plan management

#### `/src/lib/debloat-helper/` - Debloating Operations
Core debloating functionality modules:
- **Remove-ItemPropertyVerified.psm1** - Registry property deletion with verification
- **Remove-ItemVerified.psm1** - Item removal with verification
- **Remove-UWPApp.psm1** - Universal Windows Platform app removal
- **Set-CapabilityState.psm1** - Windows Capabilities management
- **Set-ItemPropertyVerified.psm1** - Registry property modification with verification
- **Set-OptionalFeatureState.psm1** - Optional Windows Features control
- **Set-ScheduledTaskState.psm1** - Scheduled task enable/disable
- **Set-ServiceStartup.psm1** - Windows service startup type management

#### `/src/lib/package-managers/` - Package Management
- **Install-PackageManager.psm1** - Generic package manager installation
- **Manage-Chocolatey.psm1** - Chocolatey package manager integration
- **Manage-Winget.psm1** - Windows Package Manager (Winget) integration
- **Manage-Software.psm1** - Generic software management interface
- **Manage-DailyUpgradeJob.psm1** - Automated daily package upgrades
- **Update-AllPackage.psm1** - Universal package update command

#### `/src/lib/ui/` - User Interface Components
- **Get-CurrentResolution.psm1** - Screen resolution detection (DPI-aware)
- **Get-DefaultColor.psm1** - Color palette management
- **New-LayoutPage.psm1** - GUI page layout creation
- **Select-Folder.psm1** - Folder selection dialog
- **Show-MessageDialog.psm1** - Multi-button message boxes (OK, Yes, No)
- **Ui-Helper.psm1** - General UI utilities

### `/src/scripts/` - Primary Debloating Operations

#### Main Optimization Scripts (Recommended Order)
1. **Backup-System.ps1** - Creates restore point and backs up hosts file
2. **Invoke-DebloatSoftware.ps1** - Main software debloating execution
3. **Optimize-TaskScheduler.ps1** - Disables unnecessary scheduled tasks
4. **Optimize-ServicesRunning.ps1** - Configures Windows services
5. **Remove-BloatwareAppsList.ps1** - Removes preinstalled bloatware apps
6. **Optimize-Privacy.ps1** - Privacy-related tweaks
7. **Optimize-Performance.ps1** - Performance optimizations (handles SSD detection)
8. **Register-PersonalTweaksList.ps1** - Custom personal tweaks
9. **Optimize-Security.ps1** - Security hardening tweaks
10. **Remove-CapabilitiesList.ps1** - Removes Windows Capabilities
11. **Optimize-WindowsFeaturesList.ps1** - Manages optional Windows features

#### Specialized Removal Scripts
- **Remove-BloatwareAppsList.ps1** - Dell, Samsung, MS Edge bloatware
- **Remove-MSEdge.ps1** - Microsoft Edge removal (improved)
- **Remove-OneDrive.ps1** - OneDrive removal
- **Remove-TemporaryFiles.ps1** - Temp file cleanup
- **Remove-WindowsOld.ps1** - Windows.old folder cleanup
- **Remove-Xbox.ps1** - Xbox app removal (partial reinstall possible)

#### System Maintenance Scripts
- **Repair-WindowsSystem.ps1** - System repair functionality
- **Start-DiskCleanUp.ps1** - Disk cleanup operations

#### `/src/scripts/other-scripts/` - Specialized Tools
- **Git-GnupgSshKeysSetup.ps1** - Git/GPG/SSH key configuration
- **Install-ArchWSL.ps1** - Arch Linux WSL2 installation
- **Install-NerdFont.ps1** - Nerd fonts installation
- **Install-WSL.ps1** - WSL2 full installation
- **New-SystemColor.ps1** - Windows color scheme customization
- **Show-DebloatInfo.ps1** - Display debloat information

### `/src/utils/` - Utilities & Tweaks

#### Registry Files (`.reg`)
- **disable-photo-viewer.reg** / **enable-photo-viewer.reg**
- **disable-take-ownership-context-menu.reg** / **enable-take-ownership-context-menu.reg**
- **fix-url-association.reg** - URL handler fix

#### PowerShell Utilities
- **Individual-Tweaks.psm1** - Collection of individual system tweaks

#### `/src/utils/DIY/` - Advanced Customization
- **Optimize-SSD.ps1** - SSD-specific optimizations
- **Restart-AdvancedMode.ps1** - Advanced boot mode management
- Additional custom scripts

### `/src/configs/` - Configuration Files

#### `/src/configs/shutup10/`
- **ooshutup10-default.cfg** - Default O&O ShutUp10++ configuration
- **ooshutup10.cfg** - Custom O&O ShutUp10++ settings

### `/src/assets/` - Project Resources
- Script logo and branding images
- UI graphics
- PowerShell icon reference

---

## 🚀 Execution Modes

### GUI Mode (Default)
```powershell
.\WinDebloatTools.ps1
```
Features:
- Organized tabbed interface
- Category-based tweaks (Tasks, Services, Features, Capabilities, etc.)
- Point-and-click application
- "Apply Tweaks" button for main debloating
- "Undo Tweaks" button for rollback
- "Repair Windows" button for system repair
- DPI-aware and resolution-responsive
- Multi-monitor support

### CLI Mode (Direct Execution)
```powershell
.\WinDebloatTools.ps1 'CLI'
```
- Runs optimization scripts in recommended order
- No user interaction
- Suitable for automation
- Ideal for batch deployments

---

## ⚙️ Core Functionality

### Debloating Operations
- **UWP App Removal** - Remove Store applications
- **Scheduled Task Disabling** - Disable unnecessary background tasks
- **Service Management** - Set services to manual/disabled
- **Bloatware Removal** - Remove OEM/manufacturer bloatware
- **Windows Features** - Remove optional features
- **Windows Capabilities** - Remove optional capabilities

### Optimization Features
- **Performance Tweaks** - Disk, memory, CPU optimizations
- **SSD Detection** - Automatically keeps SysMain/WSearch enabled on SSDs
- **Power Plans** - Creates/registers optimized power plans (removes duplicates)
- **Privacy Controls** - Telemetry and data collection restrictions
- **Security Hardening** - Windows security enhancements

### System Management
- **Restore Points** - Automatic creation before major changes
- **Hosts File Backup** - Creates backup for rollback
- **Logging System** - Comprehensive operation logging
- **Revert Capability** - Track and restore previous states
- **Registry Verification** - Verify registry operations succeed

### Package Management
- **Winget** - Windows Package Manager support
- **Chocolatey** - Alternative package manager support
- **Daily Upgrade Jobs** - Automated update scheduling

---

## 🔄️ Important Features

### Rollback/Undo Mechanism
1. **GUI "Undo Tweaks" Button** - Reverts most changes
2. **Automatic Restore Point** - Created by Backup-System.ps1
3. **Hosts File Backup** - Stored for network restoration
4. **Revert Status Tracking** - Maintains state of changes

### Safety Features
- **Admin Privilege Requirement** - Enforced at startup
- **Script Validation** - PSScriptAnalyzer CI/CD checks
- **Logging** - All operations logged to `AppData\Local\Temp\Win-DT-Logs`
- **Registry Verification** - Confirms operations succeeded
- **Item Verification** - Validates removal/modification

### Hardware Considerations
- **SSD vs HDD Detection** - Different optimizations based on storage type
- **DPI Awareness** - GUI scales with system DPI
- **Multi-Monitor Support** - Resolution detection for proper scaling
- **Architecture Specific** - x86/x64 only (ARM/ARM64 incompatible)

---

## 📝 Workflow & Recommendations

### Initial Setup (Fresh Windows Install)
1. Extract entire `.zip` file
2. Run `OpenTerminalHere.cmd` as admin
3. Execute GUI version for selective tweaking
4. Or use CLI mode for full debloat

### Key Considerations
- Use on fresh Windows install for maximum impact
- Admin account recommended for compatibility
- Test individual scripts first if unsure
- Create system restore point (done automatically)
- Monitor disk space after cleanup operations

### Reverting Changes
1. Use "Undo Tweaks" button if available
2. Use automatic restore point
3. Restore hosts file from backup if needed
4. Use "Repair Windows" for system repair
5. Individual scripts can be re-run with opposite parameters

---

## 🔧 Development Notes

### Module Import Pattern
- All modules use `Import-Module -DisableNameChecking -Force`
- Modules are loaded from relative paths within `$PSScriptRoot`
- Avoids naming conflicts with built-in cmdlets

### Naming Conventions
- Scripts: `Verb-Noun.ps1` (e.g., `Remove-Bloatware.ps1`)
- Functions: `Verb-Noun` (e.g., `Remove-UWPApp`)
- Variables: `$CamelCase` for local, `$Script:CamelCase` for script-scope
- Configuration: `.cfg` extension for config files

### Error Handling Patterns
- Verification functions check operation success
- Registry operations use `-ErrorAction` handling
- Item removal verified before reporting success
- Logging captures all major operations

### Configuration Management
- OOShutUp10++ config files in `/src/configs/shutup10/`
- Individual tweaks centralized in modular functions
- Registry `.reg` files for optional tweaks
- Settings persist across script runs

---

## 🎯 Common Tasks for Agents

### Adding a New Debloating Operation
1. Create function in appropriate `/src/lib/debloat-helper/` module
2. Add verification wrapper (e.g., `Remove-ItemVerified`)
3. Integrate into `/src/scripts/` optimization script
4. Add GUI component in relevant category
5. Test rollback capability

### Modifying GUI
1. Edit layout in `/src/lib/ui/New-LayoutPage.psm1`
2. Update colors in `/src/lib/ui/Get-DefaultColor.psm1`
3. Add buttons/controls to relevant script
4. Test DPI scaling and multi-monitor

### Adding Package Manager Support
1. Create module in `/src/lib/package-managers/`
2. Implement install/uninstall/update functions
3. Integrate with `Manage-Software.psm1`
4. Add to automatic update jobs if needed

### Extending Optimization Scripts
1. Add functions to appropriate optimization script
2. Implement Registry verification pattern
3. Add to revert tracking system
4. Update GUI with new controls if needed

---

## 📚 Key Dependencies

- **PowerShell 5.1+** - Core runtime
- **Windows 10/11** - Target OS
- **Administrator Privileges** - Required for execution
- **Optional: Winget** - Modern package management
- **Optional: Chocolatey** - Alternative package management
- **Optional: WSL2** - For Linux subsystem features
- **Optional: O&O ShutUp10++** - Advanced tweaking integration

---

## ⚠️ Important Warnings

- **Not all removed features restore easily** - Backup important data
- **System stability risk** - Some tweaks may impact functionality
- **Vendor customizations may be removed** - OEM software deleted
- **User assumes all responsibility** - Testing recommended
- **Fresh install recommended** - Maximum compatibility
- **Backup system beforehand** - Protect critical data

---

## 🔗 Project References

- Adapted from: [W4RH4WK's Debloat-Windows-10](https://github.com/W4RH4WK/Debloat-Windows-10)
- Influenced by: [ChrisTitusTech's win10script](https://github.com/ChrisTitusTech/win10script)
- Influenced by: [Sycnex's Windows10Debloater](https://github.com/Sycnex/Windows10Debloater)

---

## 📄 Documentation Files

- `README.md` - User quick-start guide
- `ROADMAP.md` - Development history and version notes
- `CONTRIBUTING.md` - Contribution guidelines
- `AGENTS.md` - This file (AI/Agent working guide)
