# Author: Romain Si
# Description: Query DHCP Server information
# 
# This script is intended for use with Zabbix > 3.x
#
#
# USAGE:
#   as a script:    C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -command  "& C:\Zabbix\zabbix_dhcp_scope.ps1 <ITEM_TO_QUERY> <SCOPE>"
#   as an item:     dhcp[<ITEM_TO_QUERY>,<SCOPE>]
#
# Add to Zabbix Agent
#   UserParameter=dhcp[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\zabbix_dhcp_scope.ps1" "$1" "$2"
#

$ITEM = [string]$args[0]
$ID = [string]$args[1]

switch ($ITEM) {
  "Discovery" {
    # Open JSON object
    $output =  "{`"data`":["
      $query = Get-DhcpServerv6ScopeStatistics | Where {$_.Free -gt 0} | Select-Object Prefix
      $count = $query | Measure-Object
      $count = $count.count
      foreach ($object in $query) {
        $Id = [string]$object.Prefix
        if ($count -eq 1) {
          $output = $output + "{`"{#Prefix}`":`"$Id`"}"
        } else {
          $output = $output + "{`"{#Prefix}`":`"$Id`"},"
        }
        $count--
    }
    # Close JSON object
    $output = $output + "]}"
    Write-Host $output
  }
   
   "ScopeFree" {
  $query = Get-DhcpServerv6ScopeStatistics | Where-Object {$_.Prefix -like "*$ID*"} | Select-Object Free
  foreach ($object in $query) {
  $Free = [string]$object.Free}
  $Free
    }

   "ScopeInUse" {
  $query = Get-DhcpServerv6ScopeStatistics | Where-Object {$_.Prefix -like "*$ID*"} | Select-Object InUse
  foreach ($object in $query) {
  $InUse = [string]$object.InUse}
  $InUse
    }
    
   "ScopePercentageInUse" {
  $query = Get-DhcpServerv6ScopeStatistics | Where-Object {$_.Prefix -like "*$ID*"} | Select-Object PercentageInUse
  foreach ($object in $query) {
  $PercentageInUse = [string]$object.PercentageInUse}
  $PercentageInUse
    } 

   "ScopeReserved" {
  $query = Get-DhcpServerv6ScopeStatistics | Where-Object {$_.Prefix -like "*$ID*"} | Select-Object Reserved
  foreach ($object in $query) {
  $Reserved = [string]$object.Reserved}
  $Reserved
    } 
 
  default {
      Write-Host "-- ERREUR -- : Besoin d'une option !"
  }
}
