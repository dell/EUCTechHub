# Returns value for BIOS Security AdminPW
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
   This PowerShell is using WMI WMI Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject and -Namespace root/DCIM/SYSMAN/biosattributes -ClassName EnumerationAttribute. Select Value for BIOS Security AdminPW.
   IMPORTANT: This Script support Devices newer than 2018 otherwise BIOS WMI is not support on Hardware
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Class WMI Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>

function SwitchtoText{
    
    # Parameter
    param(
        [string]$Value
        
         )

      
    # Prepare value to convert from number to text
    $Value = Switch ($Value)
        {
        0 {"Disabled"}
        1 {"Enabled"}
        }

           
    Return $Value
     
}


#select values from WMI Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject
$Security_Password = Get-CimInstance -Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject


#select values from $Security_Password
$Security_AdminPW_Value = $Security_Password | Where-Object {$_.NameID -eq "Admin"} | select -ExpandProperty IsPasswordSet

# change value $Security_AdminPW_Value and $Security_SystemPW_Value from number to text
$Security_AdminPW_Value = SwitchtoText -Value $Security_AdminPW_Value


#Prepare output string
$OutputStatement = $Security_AdminPW_Value

Write-Output $OutputStatement