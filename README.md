# Zabbix-dhcp_scope

Work on Windows Server.

This template use PowerShell Cmdlets to discover all informations for Microsoft DHCP Server Scope in one shot and send it to zabbix server/proxy in json.

Default French translation.

Items : IPs availables in dhcp scope, Number of IPs reserved, Number of IPs used, Percentage of IPs used and state DhcpServer service.

 -------- Item --------

State DHCPSERVER

-------- Triggers --------

[HIGH] => Service DHCPServer Stop

Discovery : All Scope in DHCP Server

Triggers : [AVERAGE] => More than 5 IPs available in the Scope range


Install :

Import template,

Install the Zabbix agent2 on your host,

Copy zabbix_dhcp_scope.ps1 in your zabbix agent2 directory,

Add the following line to your Zabbix agent configuration file :
`UnsafeUserParameters=1`
`AllowKey=system.run[*]` (or create userparameter and change zabbix item "Start DHCP Job").
