<#
_author_ = Gus Chavira <g_chavira@dell.com>
_version_ = 1.0
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

<#
.Synopsis
   xxxx PowerShell script used to determine if Dell Command Update has a BIOS update available (only checks BIOS updates) AND Apply that update to device .
   IMPORTANT: Requires latest version of Dell Command Update be deployed to device (or whatever requirements if any or OS versions)
   IMPORTANT: https://www.dell.com/support/home/en-us/drivers/DriversDetails?driverId=8DGG4
   IMPORTANT: This script will reboot the system to apply via policy in Dell Command Update
.DESCRIPTION
   PowerShell script used to determine if Dell Command Update has a BIOS update available (only checks BIOS updates).
   IMPORTANT: 
   UAC in Windows may need to be disabled so elevation of UAC dialog doesn't pop up.


.EXAMPLE
	This example shows how to retrive status to determine if Dell Command Update has a BIOS update available (only checks BIOS updates)
    Dell_DCU_New_BIOS_available_checker.ps1   <then returns output variable of $DCU which will be either be that there IS or IS NOT BIOS updates available or that is is NOT installed.>
#>


#Declare Variables for Universal app if RegKey AppCode is Universal or if Regkey AppCode is Classic and declares their variables otherwise reports not installed
If((Get-ItemPropertyValue HKLM:\SOFTWARE\DELL\UpdateService\Clients\CommandUpdate\Preferences\Settings -Name AppCode -ErrorAction SilentlyContinue) -eq "Universal"){
    $Version = Get-ItemPropertyValue HKLM:\SOFTWARE\DELL\UpdateService\Clients\CommandUpdate\Preferences\Settings -Name ProductVersion -ErrorAction SilentlyContinue
    $AppType = Get-ItemPropertyValue HKLM:\SOFTWARE\DELL\UpdateService\Clients\CommandUpdate\Preferences\Settings -Name AppCode -ErrorAction SilentlyContinue
    #Add DCU-CLI.exe as Environment Variable for Universal app type
    $env:Path = $env:Path + ';C:\Program Files\Dell\CommandUpdate\'
}
ElseIf((Get-ItemPropertyValue HKLM:\SOFTWARE\DELL\UpdateService\Clients\CommandUpdate\Preferences\Settings -Name AppCode -ErrorAction SilentlyContinue) -eq "Classic"){

    $Version = Get-ItemPropertyValue HKLM:\SOFTWARE\DELL\UpdateService\Clients\CommandUpdate\Preferences\Settings -Name ProductVersion
    $AppType = Get-ItemPropertyValue HKLM:\SOFTWARE\DELL\UpdateService\Clients\CommandUpdate\Preferences\Settings -Name AppCode
    #Add DCU-CLI.exe as Environment Variable for Classic app type
    $env:Path = $env:Path + ';C:\Program Files (x86)\Dell\CommandUpdate\'
}
Else{
        (Write-Output ("DCU is not installed"))
}

# Remove the log file from previous run if it exists
#if (Test-Path 'C:\ProgramData\Dell\WS1_UEM_SENSOR_DCUBIOS_Check.log'){
#Remove-item 'C:\ProgramData\Dell\WS1_UEM_SENSOR_DCUBIOS_Check.log' }

#Assumes Dell Command Update is installed but is checked here first
Get-ItemProperty "HKLM:\SOFTWARE\Dell\UpdateService\Clients\CommandUpdate\Preferences\Settings" -ErrorVariable err -ErrorAction SilentlyContinue >$null 2>&1
if ($err.Count -eq 0) {
 dcu-cli.exe /scan -updateType=bios -outputLog=C:\ProgramData\Dell\WS1_UEM_SENSOR_DCUBIOS_Check.log -silent >$null 2>&1
 $DCU = (Get-Content -Path C:\ProgramData\Dell\WS1_UEM_SENSOR_DCUBIOS_Check.log | Where-Object {$_ -like '*BIOS*'} )
 if ($DCU -eq $null) {
   $DCU = "Dell Command has no new BIOS updates"
   }else{
   $DCU = "Dell Command has Critical BIOS updates available"
   # Configure command below will set BitLocker to suspend to apply BIOS update and all end-user 60 minutes to reboot (which can be 5,15,30, or 60 minutes)
   dcu-cli.exe /configure -autoSuspendBitLocker=enable -scheduledReboot=60 -silent
   dcu-cli.exe /applyUpdates -updateType=bios -silent
   }
}else{
 $DCU = "Dell Command | Update Not Installed"
}
write-output $DCU