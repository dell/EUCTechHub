# Returns value for BIOS Security AdminPW, SystemPW, SecureBoot, TPM
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
   This PowerShell is using WMI Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject and -Namespace root/DCIM/SYSMAN/biosattributes -ClassName EnumerationAttribute. Select Value for BIOS Security AdminPW, SystemPW, SecureBoot, TPM.
   IMPORTANT: This Script support Devices newer than 2018 otherwise BIOS WMI is not supported on Hardware
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Class WMI Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject and -Namespace root/DCIM/SYSMAN/biosattributes -ClassName EnumerationAttribute and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
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

#Prepare variables
$OutputStatement = "Device Details: "
$Security_AdminPW = "AdminPW is set: "
$Security_SystemPW = "SystemPW is set: "
$Security_SecureBoot = "Secureboot is enabled: "
$Security_TPM = "TPM is enabled: "


#select values from WMI Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject and -Namespace root/DCIM/SYSMAN/biosattributes -ClassName EnumerationAttribute
$Security_Password = Get-CimInstance -Namespace root/DCIM/SYSMAN/wmisecurity -ClassName PasswordObject
$Security_BIOS = Get-CimInstance -Namespace root/DCIM/SYSMAN/biosattributes -ClassName EnumerationAttribute

#select values from $Security_Password and $Security_BIOS
$Security_AdminPW_Value = $Security_Password | Where-Object {$_.NameID -eq "Admin"} | select -ExpandProperty IsPasswordSet
$Security_SystemPW_Value = $Security_Password | Where-Object {$_.NameID -eq "System"} | select -ExpandProperty IsPasswordSet
$Security_SecureBoot_Value = $Security_BIOS | Where-Object {$_.AttributeName -eq "SecureBoot"} | select -ExpandProperty CurrentValue
$Security_TPM_Value = $Security_BIOS | Where-Object {$_.AttributeName -eq "TpmSecurity"} | select -ExpandProperty CurrentValue

# change value $Security_AdminPW_Value and $Security_SystemPW_Value from number to text
$Security_AdminPW_Value = SwitchtoText -Value $Security_AdminPW_Value
$Security_SystemPW_Value = SwitchtoText -Value $Security_SystemPW_Value


#Prepare output string
$OutputStatement = $OutputStatement+$Security_AdminPW+$Security_AdminPW_Value+" "+$Security_SystemPW+$Security_SystemPW_Value+" "+$Security_SecureBoot+$Security_SecureBoot_Value+" "+$Security_TPM+$Security_TPM_Value

Write-Output $OutputStatement