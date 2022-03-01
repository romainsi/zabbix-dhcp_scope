# Script: zabbix_dhcp_scope
# Author: Romainsi
# Description: Query DHCP Server information
#

$pathsender = 'C:\Program Files\Zabbix Agent 2'

$return = $null
$return = @()

$query = Get-DhcpServerv4ScopeStatistics

foreach ($item in $query) {
    $Object = $null
    $Object = New-Object System.Object
    $Object | Add-Member -type NoteProperty -Name ScopeId -Value $item.ScopeId.IPAddressToString
    $Object | Add-Member -type NoteProperty -Name Free -Value $item.Free
    $Object | Add-Member -type NoteProperty -Name InUse -Value $item.InUse
    $Object | Add-Member -type NoteProperty -Name PercentageInUse -Value $item.PercentageInUse
    $Object | Add-Member -type NoteProperty -Name Reserved -Value $item.Reserved

    $Return += $Object
}

$Return = ConvertTo-Json -Compress -InputObject @($return)
$Return = $Return -replace '"', '\"'
$Return = '\"' + $return + '\"'

cd $pathsender
.\zabbix_sender.exe -c .\zabbix_agent2.conf -k ResultsDhcpScope -o $Return
