﻿<#
_author_ = Gus Chavira <g_chavira@Dell.com>
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
   xxxx PowerShell script used for <xxxxx> .
   IMPORTANT: Requires latest version of Dell Command Update be deployed to device (or whatever requirements if any or OS versions)
   IMPORTANT: Continued info 
   IMPORTANT: This script does not reboot the system to apply or query system.  (Put in any reboot requirements if applicable here)
.DESCRIPTION
   PowerShell script used for <xxxxx>
   IMPORTANT: Any noted thing to note of importantance.
   
   - DefaultType, REQUIRED, pass in the BIOS Baseline profile name. Accepted Values are "BuiltInSafeDefaults", "LastKnownGood", "Factory", "UserConf1", "UserConf2".
   - AdminPwd, OPTIONAL, Dell BIOS Admin password, if set on the client
Describe any example use if required or note the value received and output sent for example to Workspace One Intelligence, Microsoft MEM or wherever.
.EXAMPLE
	This example shows how to reset Dell BIOS to 'BuiltInSafeDefaults' profile, when BIOS Admin password is not set on the system. Settings will not be applied until next system reboot.
    Set-DellBIOSDefaults -DefaultType "BuiltInSafeDefaults"
.EXAMPLE
	This example shows how to reset Dell BIOS to 'LastKnownGood' profile, when BIOS Admin password is not set on the system. Settings will not be applied until next system reboot.
    Set-DellBIOSDefaults -DefaultType "LastKnownGood"
.EXAMPLE
	This example shows how to reset Dell BIOS to 'Factory' profile, when BIOS Admin password is not set on the system. Settings will not be applied until next system reboot.
    Set-DellBIOSDefaults -DefaultType "Factory"
#>