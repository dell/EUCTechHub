# Returns value for HDD Partition BootPartition
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
   This PowerShell is using WMI to collect values from Win32_DiskPartition. Select Value for HDD Partition Name, BootPartition, Size
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Class Win32_DiskPartition and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>

#Prepare variables
$Partition_Boot = "Boot Partition: "
$IndexCounter = 0

#Select all values from Win32_DiskPartition
$Partition_Data = Get-CimInstance -ClassName Win32_DiskPartition

#Collect values form $Partition_Data
$Partition_Name_Value = $Partition_Data.Name
$Partition_Boot_Value = $Partition_Data.BootPartition


foreach($i in $Partition_Data)
    {
    


    $Partition = $Partition+$Partition_Name_Value[$IndexCounter]+" "+$Partition_Boot+$Partition_Boot_Value[$IndexCounter]+" "
    
    $IndexCounter = $IndexCounter + 1

    }

    
#prepare string for output
$OutputStatement = $OutputStatement+$Partition

Write-Output $OutputStatement