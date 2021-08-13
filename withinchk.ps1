<#
    .SYNOPSIS
    Check if the IP address is in the range.

    .DESCRIPTION
    Check if the IP address is in the range.
    If the IP address is in the range, this script returns 0.
    If the IP address is not in the range, this script returns 1.

    .EXAMPLE
    PS> .\withinchk.ps1 -IPAddress 192.168.54.56 -Range 192.168.54.0/20

    .EXAMPLE
    PS> .\withinchk.ps1 -IPAddress 192.168.54.56 -Range 192.168.54.54/255.255.255.248

    .EXAMPLE
    PS> .\withinchk.ps1 -IPAddress 192.168.54.56 -Range 192.168.54.56
#>

Param(
    [parameter(Mandatory=$true)][string]$IPAddress,
    [parameter(Mandatory=$true)][string]$Range
)

Import-Module "$PSScriptRoot\lib\ipchk.psm1"

$Dec2ip = "$PSScriptRoot/dec2ip.ps1"
$Ip2dec = "$PSScriptRoot/ip2dec.ps1"
$Cidr2netmask = "$PSScriptRoot/cidr2netmask.ps1"

foreach ($c in $Dec2ip, $Ip2dec, $Cidr2netmask) {
    if (!(Test-Path $c)) {
        Write-Error "Not found: $c"
        exit 1
    }
}

if (!(Test-IPAddress $IPAddress)) {
    Write-Error "Invalid argument: IPAddress $IPAddress"
    exit 1
}

$IPAddressDecimal = &$Ip2dec $IPAddress
$Network = ($Range -split '/')[0]
$Mask = ($Range -split '/')[1]
$NetworkDecimal = &$Ip2dec $Network

if ($Null -eq $Mask) {
    $Mask = '255.255.255.255'
    $MaskDecimal = &$Ip2dec $Mask
} elseif($Mask -match '^[0-9]{1,2}$') {
    $Mask = &$Cidr2netmask $Mask 2>$Null
    $MaskDecimal = &$Ip2dec $Mask
} else {
    $MaskDecimal = &$Ip2dec $Mask 2>$Null
}

$Subnet = &$Dec2ip ($NetworkDecimal -band $MaskDecimal)
if (
    $IPAddressDecimal -ge ($NetworkDecimal -band $MaskDecimal) `
    -and $IPAddressDecimal -le ($NetworkDecimal -bor (4294967295 -bxor $MaskDecimal))
) {
    Write-Host "$IPAddress is in $Subnet/$Mask"
    exit 0
} else {
    Write-Host -ForegroundColor Red "$IPAddress is not in $Subnet/$Mask"
    exit 1
}
