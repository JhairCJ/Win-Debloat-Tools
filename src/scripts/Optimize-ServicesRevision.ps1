Import-Module -DisableNameChecking "$PSScriptRoot\..\lib\Title-Templates.psm1"
Import-Module -DisableNameChecking "$PSScriptRoot\..\lib\debloat-helper\Set-ServiceStartup.psm1"

function Optimize-ServicesRevision() {
    [CmdletBinding()]
    param (
        [Switch] $Revert
    )

    $ServicesToDisabled = @(
        "dam"                                    # DEFAULT: Manual    | Desktop Activity Moderator Driver
        "GpuEnergyDrv"                           # DEFAULT: Manual    | GPU Energy Driver
        "NetBT"                                  # DEFAULT: Manual    | NetBT
        "Telemetry"                              # DEFAULT: Manual    | Intel(R) Telemetry Service
        "diagnosticshub.standardcollector.service" # DEFAULT: Manual  | Microsoft (R) Diagnostics Hub Standard Collector Service
        "WerSvc"                                 # DEFAULT: Manual    | Windows Error Reporting Service
        "DiagTrack"                              # DEFAULT: Automatic | Connected User Experiences and Telemetry
        "wisvc"                                  # DEFAULT: Manual    | Windows Insider Service
        "PcaSvc"                                 # DEFAULT: Automatic | Program Compatibility Assistant Service
        "WdiServiceHost"                         # DEFAULT: Manual    | Diagnostic Service Host
        "WdiSystemHost"                          # DEFAULT: Manual    | Diagnostic System Host
        "tcpipreg"                               # DEFAULT: Manual    | TCP/IP Registry Compatibility (experimental)
        "Wecsvc"                                 # DEFAULT: Manual    | Windows Event Collector
        "UCPD"                                   # DEFAULT: Manual    | UCPD velocity
    )

    $ServicesToManual = @(
        "edgeupdate"                             # DEFAULT: Automatic | Microsoft Edge Update Service
    )

    $ServicesToAutomatic = @(
        "condrv"                                 # DEFAULT: Manual    | CondRV (fixes error 3489660986)
    )

    Write-Title "Services Revision tweaks"
    Write-Section "Setting service startup types"

    If ($Revert) {
        Write-Status -Types "*", "Service" -Status "Reverting the tweaks is set to '$Revert'." -Warning
        Set-ServiceStartup -State 'Automatic' -Services $ServicesToDisabled
        Set-ServiceStartup -State 'Automatic' -Services $ServicesToManual
        Enable-ScheduledTask -TaskPath '\Microsoft\Windows\AppxDeploymentClient' -TaskName 'UCPD velocity' -ErrorAction SilentlyContinue
    } Else {
        Set-ServiceStartup -State 'Disabled' -Services $ServicesToDisabled
        Set-ServiceStartup -State 'Manual' -Services $ServicesToManual
        Set-ServiceStartup -State 'Automatic' -Services $ServicesToAutomatic
        Write-Status -Types "@", "Service" -Status "Disabling UCPD velocity scheduled task..."
        Disable-ScheduledTask -TaskPath '\Microsoft\Windows\AppxDeploymentClient' -TaskName 'UCPD velocity' -ErrorAction SilentlyContinue
    }
}

If (!$Revert) {
    Optimize-ServicesRevision
} Else {
    Optimize-ServicesRevision -Revert
}
