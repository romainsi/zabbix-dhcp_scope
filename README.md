================Zabbix-Microsoft-DHCP-Server ================

Work on Windows Server 2012,2012 R2

This template use PowerShell Cmdlets to discover Microsoft DHCP Server Scope.

Default French translation.

Items : IPs availables in dhcp scope, Number of IPs reserved, Number of IPs used, Percentage of IPs used 

Discovery : All Scope in DHCP Server

Triggers : [AVERAGE] => More than 5 IPs available in the Scope range

Install :

Import template,

Install the Zabbix agent on your host,

Copy zabbix_dhcp_scope.ps1 in your zabbix agent directory,

Add the following line to your Zabbix agent configuration file :

UnsafeUserParameters=1

UserParameter=dhcp[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\zabbix_dhcp_scope.ps1" "$1" "$2"
