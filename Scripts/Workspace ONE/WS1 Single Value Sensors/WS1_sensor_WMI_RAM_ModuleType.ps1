# Returns value for Count RAM Type
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
   This PowerShell is using WMI to collect values from Win32_PhysicalMemory. Select Value for Count RAM Type
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Class Win32_PhysicalMemory and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>


#Select all values from Win32_PhysicalMemory
$RAM_Data = Get-CimInstance -ClassName Win32_PhysicalMemory

#Collect values form $RAM_Data
$RAM_MemoryType_Value = $RAM_Data.SMBIOSMemoryType.Item(0)


#convert $RAM_MemoryType_Value to text

#$RAM_MemoryType_Value
$RAM_MemoryType_Value = switch ($RAM_MemoryType_Value)
   {
        0	{"Unknown"}
        1	{"Other"}
        2	{"DRAM"}
        3	{"Synchronous DRAM"}
        4	{"Cache DRAM"}
        5	{"EDO"}
        6	{"EDRAM"}
        7	{"VRAM"}
        8	{"SRAM"}
        9	{"RAM"}
        10	{"ROM"}
        11	{"Flash"}
        12	{"EEPROM"}
        13	{"FEPROM"}
        14	{"EPROM"}
        15	{"CDRAM"}
        16	{"3DRAM"}
        17	{"SDRAM"}
        18	{"SGRAM"}
        19	{"RDRAM"}
        20	{"DDR"}
        21	{"DDR-2"}
        22	{"BRAM"}
        23	{"FB-DIMM"}
        24	{"DDR3"}
        25	{"FBD2"}
        26	{"DDR4"}
        27	{"LPDDR"}
        28	{"LPDDR2"}
        29	{"LPDDR3"}
        30	{"LPDDR4"}
        31	{"Logical non-volatile device"}
        32	{"HBM (High Bandwidth Memory)"}
        33	{"HBM2 (High Bandwidth Memory Generation 2)"}
        34	{"DDR5"}
        35	{"LPDDR5"}
        32567	{"DMTF Reserved"}
        32568	{"Vendor Reserved"}

   }




#prepare string for output
$OutputStatement = $RAM_MemoryType_Value

Write-Output $OutputStatement