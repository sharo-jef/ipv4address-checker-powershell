<#
    .SYNOPSIS
    Show network range info.

    .DESCRIPTION
    Show network range info.

    .EXAMPLE
    PS> .\networkrangeinfo.ps1 192.168.54.54/255.255.255.248

    .EXAMPLE
    PS> .\networkrangeinfo.ps1 53.16.178.98/255.255.255.224
#>

Param([parameter(Mandatory=$true)][string]$Range)

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

$Network = ($Range -split '/')[0]
$Mask = ($Range -split '/')[1]

if ($Null -eq $Mask) {
    $Mask = '255.255.255.255'
    $MaskDecimal = &$Ip2dec $Mask
} elseif ($Mask -match '^[0-9]{1,2}$') {
    $Mask = &$Cidr2netmask $Mask 2>$Null
    $MaskDecimal = &$Ip2dec $Mask 2>$Null
} else {
    $MaskDecimal = &$Ip2dec $Mask 2>$Null
}

$NetworkDecimal = &$Ip2dec $Network

$StartDecimal = $NetworkDecimal -band $MaskDecimal
$EndDecimal = $NetworkDecimal -bor (4294967295 -bxor $MaskDecimal)
$StartAddress = &$Dec2ip $StartDecimal
$EndAddress = &$Dec2ip $EndDecimal
$NumOfIP = $EndDecimal - $StartDecimal + 1

@{
    StartAddress = $StartAddress
    EndAddress = $EndAddress
    Mask = $Mask
    NumOfIP = $NumOfIP
}
