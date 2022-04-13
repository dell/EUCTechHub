# Returns value for BIOS ReleaseDate, ReleaseAge and BIOS Version
# Return Type: String
# Execution Context: System
# Author: Sven Riebe


<#
_author_ = Sven Riebe <sven_riebe@Dell.com>
_twitter_ = @SvenRiebe
_version_ = 1.0.0
_Dev_Status_ = Test
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

<#Version Changes

1.0.0   inital version


#>

<#
.Synopsis
   This PowerShell is using WMI Win32_BIOS Class. Select Value for BIOS ReleaseDate, ReleaseAge and BIOS Version.
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Class Win32_BIOS and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>
#Prepare variables
$OutputStatement = "Device Details: "
$BIOS_ReleaseDate = "BIOS Release Date (DD/MM/YYYY): "
$BIOS_Version = "BIOS Version: "
$BIOS_ReleaseAge = "BIOS Release Age in Days: "
$Today = Get-Date -Format dd/MM/yyyy

#select values from WMI Win32_Bios Class
$BIOS_ReleaseDate_Value = (Get-CimInstance -ClassName Win32_BIOS).ReleaseDate
$BIOS_Version_Value = (Get-CimInstance -ClassName Win32_BIOS).SMBIOSBIOSVersion

#compare BIOS Date and Today and reports age of day by BIOS Release
$BIOS_ReleaseAge_Value = New-TimeSpan -Start $BIOS_ReleaseDate_Value.ToShortDateString() -End $Today

#Prepare output string
$OutputStatement = $OutputStatement+$BIOS_Version+$BIOS_Version_Value+" "+$BIOS_ReleaseDate+$BIOS_ReleaseDate_Value.ToShortDateString()+" "+$BIOS_ReleaseAge+$BIOS_ReleaseAge_Value.Days


Write-Output $OutputStatement