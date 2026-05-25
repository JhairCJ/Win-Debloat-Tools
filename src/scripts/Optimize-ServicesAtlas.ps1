Import-Module -DisableNameChecking "$PSScriptRoot\..\lib\Title-Templates.psm1"
Import-Module -DisableNameChecking "$PSScriptRoot\..\lib\debloat-helper\Set-ServiceStartup.psm1"

function Optimize-ServicesAtlas() {
    [CmdletBinding()]
    param (
        [Switch] $Revert
    )

    $ServicesToDisabled = @(
        "OneSyncSvc"                             # DEFAULT: Automatic | Sync Host
        "TrkWks"                                 # DEFAULT: Automatic | Distributed Link Tracking Client
        "PcaSvc"                                 # DEFAULT: Automatic | Program Compatibility Assistant Service
        "DiagTrack"                              # DEFAULT: Automatic | Connected User Experiences and Telemetry
        "diagnosticshub.standardcollector.service" # DEFAULT: Manual  | Microsoft (R) Diagnostics Hub Standard Collector Service
        "WerSvc"                                 # DEFAULT: Manual    | Windows Error Reporting Service
        "wercplsupport"                          # DEFAULT: Manual    | Problem Reports and Solutions Control Panel Support
        "UCPD"                                   # DEFAULT: Manual    | UCPD velocity
    )

    Write-Title "Services Atlas tweaks"
    Write-Section "Setting service startup types"

    If ($Revert) {
        Write-Status -Types "*", "Service" -Status "Reverting the tweaks is set to '$Revert'." -Warning
        Set-ServiceStartup -State 'Automatic' -Services $ServicesToDisabled
    } Else {
        Set-ServiceStartup -State 'Disabled' -Services $ServicesToDisabled
    }
}

If (!$Revert) {
    Optimize-ServicesAtlas
} Else {
    Optimize-ServicesAtlas -Revert
}
