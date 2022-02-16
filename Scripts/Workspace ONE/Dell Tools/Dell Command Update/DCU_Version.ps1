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
   xxxx PowerShell script used for return of Dell Command Update install state .
   IMPORTANT: Requires latest version of Dell Command Update be deployed to device (or whatever requirements if any or OS versions)
   IMPORTANT: https://www.dell.com/support/home/en-us/drivers/DriversDetails?driverId=8DGG4
   IMPORTANT: This script does not reboot the system to apply or query system.  (Put in any reboot requirements if applicable here)
.DESCRIPTION
   PowerShell script used for return of Dell Command Update install state
   IMPORTANT: 


.EXAMPLE
	This example shows how to retrive status as to whether Dell Command Update is installed
    DCU_Version.ps1   <then returns output variable of $DCU which will either be DCU version or that is is NOT installed.>
#>


$DCU=(Get-ItemProperty "HKLM:\SOFTWARE\Dell\UpdateService\Clients\CommandUpdate\Preferences\Settings" -ErrorVariable err -ErrorAction SilentlyContinue)
if ($err.Count -eq 0) {
 $DCU = $DCU.ProductVersion
}else{
 $DCU = "Dell Command | Update Not Installed"
}
write-output $DCU