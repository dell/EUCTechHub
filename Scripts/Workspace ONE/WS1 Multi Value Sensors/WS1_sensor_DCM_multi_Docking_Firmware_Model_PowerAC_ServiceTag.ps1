# Returns value for Docking Firmware, Model, PowerAC, ServiceTag
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
   This PowerShell is using Dell Command | Monitor to collect values from DCIM_Chassis Class. Select Value for Docking Firmware, Model, PowerAC, ServiceTag
   IMPORTANT: You need to install Dell Command | Monitor first and Battery is only availible for mobile devices.
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using Dell Command | Monitor for selcect values of Class DCIM_Chassis and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
    
#>
#Prepare variables
$OutputStatement = "Device Details: "
$Dock_Name = "Model: "
$Dock_Tag = "ServiceTag: "
$Dock_Firmware = "FirmwareVersion: "
$Dock_PowerSupply = "PowerSupply: "

#Select value of class DCIM_Chassis
$Dock_data = Get-CimInstance -Namespace root/DCIM/SYSMAN -ClassName DCIM_Chassis

#collect values from $Dock_data
$Dock_Name_Value = $Dock_data.Name
$Dock_Tag_Value = $Dock_data.Tag
$Dock_Firmware_Value = $Dock_data.Version
$Dock_PowerSupply_Value = $Dock_data.Model
$Check_CreationClassName = $Dock_data.CreationClassName
$DeviceCounter = 0

#Checking Device Type docking is only for mobile devices only

#Check the ChassisType
$Check_Chassis_Type = Get-CimInstance -ClassName Win32_SystemEnclosure | select -ExpandProperty ChassisTypes

if (($Check_Chassis_Type -eq 10) -or ($Check_Chassis_Type -eq 31) -or ($Check_Chassis_Type -eq 32))
    {


    # Select Docking Values from Array
    Foreach($i in $Dock_data)
        {
    
        if($Check_CreationClassName[$DeviceCounter] -eq "DCIM_DockingStation")
            {

            $OutputStatement = $OutputStatement+$Dock_Name+$Dock_Name_Value[$DeviceCounter]+" "+$Dock_Tag+$Dock_Tag_Value[$DeviceCounter]+" "+$Dock_Firmware+$Dock_Firmware_Value[$DeviceCounter]+" "+$Dock_PowerSupply+$Dock_PowerSupply_Value[$DeviceCounter]

            }
        
            $DeviceCounter = $DeviceCounter +1

        }

    If($OutputStatement -eq "Device Details: ")
        {

        $OutputStatement = "No dock is attached"

        }
    }

Write-Output $OutputStatement