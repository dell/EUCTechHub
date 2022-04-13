# Returns value for OS ReleaseName and Language
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
   This PowerShell is using WMI Win32_OperatingSystem. Select Value for OS Version and translate NameID to Offical ReleaseName, Language.
   IMPORTANT: You need Workspace One UEM and Intelligence to using the full function of this Sensor.
   IMPORTANT: This script does not reboot the system to apply or query system.
.DESCRIPTION
   Powershell is using WMI for selcect values of Win32_OperatingSystem and handover to Workspace One.You need import this script in the Device / Sensors secetion in Workspace One UEM.
   
#>
#Prepare variables
$OutputStatement = "Device Details: "
$OS_Version = "OS Version: "
$OS_Language = "OS Language: "



#select values from WMI Win32_OperatingSysteme
$OS_Version_Value = Get-CimInstance -ClassName Win32_OperatingSystem | select -ExpandProperty Version
$OS_Languages_Value = (Get-WinUserLanguageList).LocalizedName


$OS_Version_Value = Switch ($OS_Version_Value)
{
    10.0.10240 {"Windows 10 1507 - Threshold 1"}
    10.0.10586 {"Windows 10 1511 - Threshold 2"}
    10.0.14393 {"Windows 10 1607 - Redstone 1"}
    10.0.15063 {"Windows 10 1703 - Redstone 2"}
    10.0.16299 {"Windows 10 1709 - Redstone 3"}
    10.0.17134 {"Windows 10 1803 - Redstone 4"}
    10.0.18362 {"Windows 10 1903 - 19H1"}
    10.0.18363 {"Windows 10 1909 - 19H2"}
    10.0.19041 {"Windows 10 2004 - 20H1"}
    10.0.19042 {"Windows 10 20H2"}
    10.0.19043 {"Windows 10 21H1"}
    10.0.19044 {"Windows 10 21H2"}
    10.0.22000 {"Windows 11 21H2"}

    #need to maintain list from 08th april 2022
     
    }





#Prepare output string
$OutputStatement = $OutputStatement+$OS_Version+$OS_Version_Value+" "+$OS_Language+$OS_Languages_Value

Write-Output $OutputStatement