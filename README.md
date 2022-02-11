# EUCTechHub
# *EUCTechHub client script library*
PowerShell scripting for to support a variety of platforms such as VMware Workspace One, Microsoft MEM, and others.
Sample scripts are written in PowerShell that illustrates the usage of these scripts with UEM management and dashboarding and analytics platforms to provide various
data elements from Dell client tools or OS. 

## *Windows Management Instrumentation and PowerShell*
Windows Management Instrumentation (WMI) is the infrastructure to manage the data and operations on Windows based operating systems. 

PowerShell offers cross-platform task automation and configuration management framework through command-line instructions and scripting language. 

Most of the Dell commercial client systems are Windows-based, WMI and PowerShell are available in the IT infrastructure. This allows the IT professionals to integrate the scripts with their existing infrastructure or develop custom scripts based on their requirements. Microsoft has done a great job enhancing the PowerShell capabilities to integrate and manage WMI infrastructure.

The Dell commercial client BIOS offers configurable entities through WMI, and the script library provides sample scripts to accomplish the tasks. This method configures the Dell business client systems that contain the common interface across multiple brands, including Latitude, OptiPlex, Precision, and XPS laptops. It enhances the hardware management features and does not change across the various versions of the Windows operating systems.

## *Learning more about WMI and PowerShell*
For more details on WMI, see [https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmi-start-page]
For more details on PowerShell, see [https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7]
For more details on Agentless BIOS manageability, see [https://downloads.dell.com/manuals/common/dell-agentless-client-manageability.pdf]

## *VMware Workspace ONE UEM and Intelligenice*
VMware Workspace ONE is a cloud-based service that focuses on Unified Endpoint Management (UEM).
For more details on Microsoft Intune, see 
[https://www.vmware.com/products/workspace-one.html]

## *Microsoft Intune*
Microsoft Intune is a cloud-based service that focuses on Mobile Device Management (MDM).
For more details on Microsoft Intune, see 
[https://docs.microsoft.com/en-us/mem/intune/fundamentals/what-is-intune]

## *Deploying a PowerShell script from Intune*
The Microsoft Intune management extension allows you to upload the PowerShell scripts in Intune. You can run these scripts on the systems which are running on Windows 10 operating systems. The management extension enhances the Mobile Device Management (MDM) capabilities. 
For more information about Deploying a PowerShell script from Intune, see 
[https://docs.microsoft.com/en-us/mem/intune/apps/intune-management-extension]

## *Client script library*

This GitHub library offers the PowerShell scripts that illustrate the usage of the agentless BIOS manageability to perform the following BIOS operations:
*	Configure BIOS passwords
*	Configure BIOS attribute(s)
*	Configure BIOS baseline (example, Reset BIOS to default factory settings)
*	Configure Trusted Platform Module (TPM)
*	Configure Persistence (Absolute)
*	Configure Boot Order

### *Prerequisites*
*	Dell commercial client systems that are released to market after calendar year 2018
*	Windows operating system
*	PowerShell 5.0 or later

## *Support*
This code is provided to help the open-source community and currently not supported by Dell.

## *Provide feedback or report an issue*
You can provide further feedback or report an issue by using the following link 
[https://github.com/dell/EUCTechHub]

