# ipv4address-checker-powershell
[taniguti/ipv4address-checker](https://github.com/taniguti/ipv4address-checker) の PowerShell 版

## ip2dec
```powershell
./ip2dec 192.168.54.56
3232249400
```

## dec2ip
```powershell
./dec2ip 3232249403
192.168.54.59
```

## cidr2netmask
```powershell
./cidr2netmask 18
255.255.192.0
```

## withinchk
```powershell
# return code is 0
./withinchk -i 192.168.54.56 -r 192.168.54.0/20
192.168.54.56 is in 192.168.48.0/255.255.240.0

# return code is 1
./withinchk -i 192.168.54.56 -r 192.168.54.54/255.255.255.248
192.168.54.56 is not in 192.168.54.48/255.255.255.248

# return code is 0
./withinchk -i 192.168.54.56 -r 192.168.54.56
192.168.54.56 is in 192.168.54.56/255.255.255.255
```

## networkrangeinfo
```powershell
./networkrangeinfo 192.168.54.54/255.255.255.248

Name                           Value
----                           -----
EndAddress                     192.168.54.55
NumOfIP                        8
Mask                           255.255.255.248
StartAddress                   192.168.54.48

./networkrangeinfo 53.16.178.98/255.255.255.224

Name                           Value
----                           -----
EndAddress                     53.16.178.127
NumOfIP                        32
Mask                           255.255.255.224
StartAddress                   53.16.178.96
```
