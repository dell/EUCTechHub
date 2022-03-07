<#
_author_ = Gus Chavira <g_chavira@dell.com>
_version_ = 1.0
Copyright © 2022 Dell Inc. or its subsidiaries. All Rights Reserved.

No implied support and test in test environment/device before using in any production environment.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

<#
.Synopsis
   PowerShell script used to determine get if a Warranty exists or not for a given Dell device using Dell Command Monitor
   IMPORTANT: Requires latest version of Dell Command Monitor be deployed to device (or whatever requirements if any or OS versions)
   IMPORTANT: https://www.dell.com/support/home/en-us/drivers/DriversDetails?driverId=JD76W
   IMPORTANT: This script will not reboot the system
.DESCRIPTION
   PowerShell script used to determine get if a Warranty exists or not for a given Dell device using Dell Command Monitor
   IMPORTANT: 
   UAC in Windows may need to be disabled so elevation of UAC dialog doesn't pop up.


.EXAMPLE
	This example shows how to retrive status of warranty of a Dell device with Dell Command Monitor 
    Dell_DCU_New_BIOS_available_checker.ps1   <then returns output of either be that there IS or IS NOT Warranty in force.>
#>

$installed = Test-Path -Path "C:\Program Files\Dell\Command Monitor"
If ($installed -eq "True")
{
$app = Get-WmiObject -Class Win32_Product -Filter "Name = 'Dell Command | Monitor'"
if ($app.Name -like "Dell Command | Monitor") 
{
$date = Get-Date
$warranty = gwmi -namespace root/dcim/sysman dcim_assetwarrantyinformation | select name,warrantyenddate,pscomputername
if ($warranty[0].warrantyenddate -ge $date)
{
Write-Output "Warranty Exists"
}
else
{
Write-Output "Warranty Expired"
}
}
}