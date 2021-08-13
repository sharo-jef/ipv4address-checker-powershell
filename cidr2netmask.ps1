<#
    .SYNOPSIS
    Convert cidr to netmask.

    .DESCRIPTION
    Convert cidr to netmask.
    Cidr value must be in range of 0 to 32.

    .EXAMPLE
    PS> .\cidr2netmask.ps1 -Cidr 18
#>

Param([parameter(Mandatory=$true)][Int64]$Cidr)

if ($Cidr -lt 0 -or $Cidr -gt 32) {
    Write-Error "Invalid argument: Cidr $Cidr"
    exit 1
}

if (!(Test-Path "$PSScriptRoot/dec2ip.ps1")) {
    Write-Error "Not found: $PSScriptRoot/dec2ip.ps1"
    exit 1
}

$NetmaskDecimal = 4294967295 -bxor ([Math]::Pow(2, (32 - $Cidr)) - 1)
&"$PSScriptRoot/dec2ip.ps1" $NetmaskDecimal
