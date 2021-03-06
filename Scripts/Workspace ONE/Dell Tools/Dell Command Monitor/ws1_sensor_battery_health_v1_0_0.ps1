<#
_author_ = Sven Riebe  <sven_riebe@dell.com>
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
   xxxx PowerShell script used for return of battery health state .
   IMPORTANT: Requires latest version of Dell Command Monitor be deployed to device (or whatever requirements if any or OS versions)
   IMPORTANT: https://www.dell.com/support/kbdoc/en-us/000177080/dell-command-monitor 
   IMPORTANT: This script does not reboot the system to apply or query system.  (Put in any reboot requirements if applicable here)
.DESCRIPTION
   PowerShell script used for return of battery health state
   IMPORTANT: 


.EXAMPLE
	This example shows how to reset Dell BIOS to 'BuiltInSafeDefaults' profile, when BIOS Admin password is not set on the system. Settings will not be applied until next system reboot.
    ws1_sensor_battery_health_v1_0_0   <then returns output variable of $battery_healthstate in one of codes associated with battery health>
#>

$battery_healthstate = Switch (Get-CimInstance -Namespace root\dcim\sysman -ClassName DCIM_Battery | Select -ExpandProperty HealthState)
{
    0 {"Unknown"}
    5 {"OK"}
    10 {"Degraded/Warning"}
    15 {"Minor failure"}
    20 {"Major failure"}
    25 {"Critical failure"}
    30 {"Non-recoverable error"}
    }
write-output $battery_healthstate