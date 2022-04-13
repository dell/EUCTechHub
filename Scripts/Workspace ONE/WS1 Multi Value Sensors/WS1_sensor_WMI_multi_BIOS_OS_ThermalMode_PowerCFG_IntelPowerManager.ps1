# Returns value for BIOS/Windows values for ThermalMode, PowerCFG
# Return Type: String
# Execution Context: System
# Author: Sven Riebe


<#
_author_ = Sven Riebe <sven_riebe@Dell.com>
_twitter_ = @SvenRiebe
_version_ = 1.0.2
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
1.0.1   Delete Fan Health in reason wmi shows ever OK and change to Power Settings as replacement.
1.0.2   Checking if Intel Processor Power Management is installed on device

#>

<#
.Synopsis
   This PowerShell is using WMI to collect values from Win32_FAN Class and checking powersettings. Select Value for ThermalMode, PowerCFG.
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Class Win32_FAN and powercfg and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>
#Prepare variables
$OutputStatement = "Device Details: "
$BIOS_ThermalManagement = "ThermalMode: "
$PowerCFG_Setting = "Power Setting: "
$Intel_PowerManagement = "Intel Processor Power Management: " 
$Fan_Count = "Fan Count: "


#Check the ChassisType
$Check_Chassis_Type = Get-CimInstance -ClassName Win32_SystemEnclosure | select -ExpandProperty ChassisTypes


#collect data from WIN32_FAN
$FAN_DATA = Get-CimInstance -ClassName Win32_Fan

#Count no. of Fans in class WIN32_FAN
$Fan_Count_Value = ($FAN_DATA.ActiveCooling).count


#Select value of powercfg
$PowerCFG_Setting_Value = (powercfg /getactivescheme).substring(57).replace("(","").replace(")","")

#check if Intel Processor Power Management is installed
$Intel_PowerManagement_Value = Get-ProvisioningPackage | Where-Object{$_.PackageName -like "Intel*power*"}


#Checking if Intel Processor Power Management is installed / supported on this device
if ($Intel_PowerManagement_Value -ne "")
    {

    $Intel_PowerManagement_Value = "True"

    }
Else
    {

    $Intel_PowerManagement_Value = "False"

    }



# ThermalMode is only supported on mobile devices if mobile it add infos to $OutputStatement otherwise it show value not supported.
if (($Check_Chassis_Type -eq 10) -or ($Check_Chassis_Type -eq 31) -or ($Check_Chassis_Type -eq 32))
    {

    #Select value of thermalmode currentvalue
    $BIOS_ThermalManagement_Value = Get-CimInstance -Namespace root/dcim/sysman/biosattributes -ClassName EnumerationAttribute -Filter 'AttributeName="ThermalManagement"' | select -ExpandProperty CurrentValue


    }

Else
    {

    $BIOS_ThermalManagement_Value = "not supported"

    }


$OutputStatement = $OutputStatement+$Fan_Count+$Fan_Count_Value+" "+$BIOS_ThermalManagement+$BIOS_ThermalManagement_Value+" "+$PowerCFG_Setting+$PowerCFG_Setting_Value+" "+$Intel_PowerManagement+$Intel_PowerManagement_Value

Write-Output $OutputStatement