<#
    .SYNOPSIS
    Convert IP address to decimal.

    .DESCRIPTION
    Convert IP address to decimal.

    .EXAMPLE
    PS> .\ip2dec.ps1 -IPAddress 192.168.54.56
#>

Param([parameter(Mandatory=$true)][string]$IPAddress)

Import-Module "$PSScriptRoot\lib\ipchk.psm1"

if (!(Test-IPAddress $IPAddress)) {
    Write-Error "Invalid argument: IPAddress $IPAddress"
    exit 1
}

[Int64[]]$Octets = $IPAddress.Split('.')

Write-Output (
    ($Octets[0] -shl 24) `
    + ($Octets[1] -shl 16) `
    + ($Octets[2] -shl 8) `
    + $Octets[3]
)
