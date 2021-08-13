<#
    .SYNOPSIS
    Convert decimal to IP address.

    .DESCRIPTION
    Convert decimal to IP address.
    Decimal value must be in the range of 0 to 4294967295(0xffffffff).

    .EXAMPLE
    PS> .\dec2ip.ps1 -Decimal 3232249403
#>

Param([parameter(Mandatory=$true)][Int64]$Decimal)

if ($Decimal -lt 0 -or $Decimal -gt 4294967295) {
    Write-Error "Invalid argument: Decimal $Decimal"
    exit 1
}

Write-Output('{0}.{1}.{2}.{3}' -f
    ($Decimal -shr 24),
    (($Decimal -shr 16) -band 255),
    (($Decimal -shr 8) -band 255),
    ($Decimal -band 255)
)
