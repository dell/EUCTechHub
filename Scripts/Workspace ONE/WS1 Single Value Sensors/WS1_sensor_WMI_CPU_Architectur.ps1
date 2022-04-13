# Returns value for CPU Architectured
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
   This PowerShell is using WMI to collect values from Win32_Processor. Select Value for CPU Architectur
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Class Win32_Processor and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>

#Select all values from Win32_Processor
$CPU_Data = Get-CimInstance -ClassName Win32_Processor

#Collect values form $CPU_Data
$CPU_Architecture_Value = $CPU_Data.Architecture


#convert $CPU_Architecture_Value and CPU_Family_Value from number to text

#$CPU_Architecture_Value
$CPU_Architecture_Value = switch ($CPU_Architecture_Value)
   {
        0 {"x86"}
        1 {"MIPS"}
        2 {"Alpha"}
        3 {"PowerPC"}
        5 {"ARM"}
        6 {"ia64"}
        9 {"x64"}

   }


#prepare string for output
$OutputStatement = $CPU_Architecture_Value

Write-Output $OutputStatement