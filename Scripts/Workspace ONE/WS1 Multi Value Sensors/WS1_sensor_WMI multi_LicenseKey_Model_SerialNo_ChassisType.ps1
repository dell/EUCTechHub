# Returns Windows OEM License Key, Device Model Name, Serial-No. and Chassis Tpye
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

1.0.0   initial Version

#>

<#
.Synopsis
   This PowerShell is for Workspace One UEM. Script need to be imported as Sensor and collect OEM-Win LicenseKey, Model, SerialNo and Chassis-Type for using later in Workspace One Intelligence.
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for select OEM-Win LicenseKey, Model, SerialNo and Chassis-Type and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.

#>


#Prepare variables
$OutputStatement = "Device Details: "
$oem_licencekey = "OEM LicenseKey: "
$oem_model = "Model: "
$oem_servicetag = "SerialNo: "
$oem_Chassis_type= "Formfactor: "
$oem_licencekey_value = (Get-WmiObject -query 'select * from SoftwareLicensingService‘).OA3xOriginalProductKey
$oem_model_value = Get-CimInstance -ClassName Win32_ComputerSystem | select -ExpandProperty Model
$oem_servicetag_value = Get-WmiObject -class win32_bios | Select -ExpandProperty SerialNumber
$oem_Chassis_type_value = switch (Get-CimInstance -ClassName Win32_SystemEnclosure | select -ExpandProperty ChassisTypes)
    {
    # switch number to text
    0 {"Unknown"}
    1 {"Other"}
    2 {"SMBIOS Reserved"}
    3 {"Desktop"}
    4 {"Low Profile Desktop"}
    5 {"Pizza Box"}
    6 {"Mini Tower"}
    7 {"Tower"}
    8 {"Portable"}
    9 {"LapTop"}
    10 {"Notebook"}
    11 {"Hand Held"}
    12 {"Docking Station"}
    13 {"All in One"}
    14 {"Sub Notebook"}
    15 {"Space-Saving"}
    16 {"Lunch Box"}
    17 {"Main System Chassis"}
    18 {"Expansion Chassis"}
    19 {"SubChassis"}
    20 {"Bus Expansion Chassis"}
    21 {"Peripheral Chassis"}
    22 {"Storage Chassis"}
    23 {"SMBIOS Reseved"}
    24 {"Sealed-Case PC"}
    25 {"SMBIOS Reserved"}
    26 {"CompactPCI"}
    27 {"AdvancedTCA"}
    28 {"Blade Enclosure"}
    29 {"SMBIOS Reserved"}
    30 {"Tablet"}
    31 {"Convertible"}
    32 {"Detachable"}
    33 {"IoT Gateway"}
    }
$OutputStatement = $OutputStatement + $oem_licencekey + $oem_licencekey_value + " " +  $oem_model +  $oem_model_value + " " +  $oem_servicetag + $oem_servicetag_value + " " + $oem_Chassis_type + $oem_Chassis_type_value

Write-Output $OutputStatement    