# Returns value for BatteryType
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
   This PowerShell is using Dell Command | Monitor to collect values from DCIM_Battery Class. Select Value for BatteryType.
   IMPORTANT: You need to install Dell Command | Monitor first and Battery is only availible for mobile devices.
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using Dell Command | Monitor for selcect values of Class DCIM_Battery and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>

#Checking Device Type battery is only for mobile devices only

#Check the ChassisType
$Check_Chassis_Type = Get-CimInstance -ClassName Win32_SystemEnclosure | select -ExpandProperty ChassisTypes

if (($Check_Chassis_Type -eq 10) -or ($Check_Chassis_Type -eq 31) -or ($Check_Chassis_Type -eq 32))
    {
    
    #Select value of BatteryType and convert value to text
    $DCM_Battery_Type_Value = Switch (Get-CimInstance -Namespace root\dcim\sysman -ClassName DCIM_Battery | Select -ExpandProperty Chemistry)
        {
        1 {"Other"}
        2 {"Unknown"}
        3 {"Lead Acid"}
        4 {"Nickel Cadmium"}
        5 {"Nickel Metal Hydride"}
        6 {"Lithium-ion"}
        7 {"Zinc air"}
        8 {"Lithium Polymer"}
        }

    $OutputStatement = $DCM_Battery_Type_Value
    }
Else
    {

    $OutputStatement = "no battery"

    }
Write-Output $OutputStatement