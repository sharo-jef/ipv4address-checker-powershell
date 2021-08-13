function Test-IPAddress {
    <#
        .SYNOPSIS
        Check if the string is IP address.

        .DESCRIPTION
        Check if the string is IP address.

        .PARAMETER IPAddress
        Specifies the IP address.
    #>

    Param([parameter(Mandatory=$true)][string]$IPAddress)

    if ($IPAddress -notmatch '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$') {
        return $false
    }

    [Int64[]]$Octets = $IPAddress.Split('.')

    if (
        $Octets[0] -lt 0 `
        -or $Octets[1] -lt 0 `
        -or $Octets[2] -lt 0 `
        -or $Octets[3] -lt 0 `
        -or $Octets[0] -gt 255 `
        -or $Octets[1] -gt 255 `
        -or $Octets[2] -gt 255 `
        -or $Octets[3] -gt 255
    ) {
        return $false
    }
    return $true
}
