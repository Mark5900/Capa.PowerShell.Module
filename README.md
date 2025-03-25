# Capa.PowerShell.Module
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

This modules is made to use [CapaInstaller Software Development Kit functions](https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246085/SDK+-+CapaInstaller+Software+Development+Kit+functions) in PowerShell 7 and now also supports [PowerPacks](https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455297/PowerShell+Scripting+Library).
Any help and feedback is welcome! 😁

## Installation

There is two ways to install the module.
But both ways also needs you to fulfill the requirements that can be found [here](https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246085/SDK+-+CapaInstaller+Software+Development+Kit+functions).

### With MSI 🤖

Run the [installer](https://github.com/Mark5900/Capa.PowerShell.Module/blob/1fa8b8e3503760ac9a3909eb69fa40fed2bbbf3a/Installers/Capa.PowerShell.Module.msi)

### Copy paste the files 📂

To one of the paths you find when running

```powershell
$env:PSModulePath
```

Copy all folders from [Modules](Modules/)

## How to use 🛠️

For the SDK part of the module to work correctly, you need to run PowerShell as an administrator or else you will get the error

```powershell
OperationStopped: Requested registry access is not allowed.
```

When running the command Initialize-CapaSDK because it sets a splitter used to spilt returned array so it is made into an object array.
For more documentation look in the [documentation folder](Documentation/).

### How to import module

You can import the whole module

```powershell
Import-Module Capa.PowerShell.Module
```

You can import only the SDK part of the module

```powershell
Import-Module Capa.PowerShell.Module.SDK
```

Or you can import smaller part of the module

```powershell
Import-Module Capa.PowerShell.Module.SDK.Authentication
Import-Module Capa.PowerShell.Module.SDK.User
```

### PowerPack

To import all PowerPack commands run

```powershell
    Import-Module Capa.PowerShell.Module.PowerPack
```

There are some usefull [VSCode PowerPack snippets](Documentation/VSCODE%20PowerPack%20snippets.md) that you can use if you want to.

### Working with Git when creating or updating a package

If you want to know how to use Git when creating or updating a package, you can read [this document](Documentation\Working%20with%20Git%20when%20creating%20or%20updating%20a%20package.md).

### A exampel

```powershell
Import-Module Capa.PowerShell.Module.SDK.Authentication
Import-Module Capa.PowerShell.Module.SDK.Units
<#
    .NOTES
    ===========================================================================
    Created with: 	Visual Studio Code
    Created on:
    Created by:   	MARA
    Organization: IT-Center Fyn
    Filename:
    ===========================================================================
    .DESCRIPTION
        TODO: A description of the file.
#>
##################
### PARAMETERS ###
##################
# DO NOT CHANGE
# Change as needed
$CapaServer = 'CISRVKURSUS'
$Database = 'CapaInstaller'
$DefaultManagementPointDev = '1'
$DefaultManagementPointProd = $null #Keep null if you don't have two enviroments

#################
### FUNCTIONS ###
#################

##############
### SCRIPT ###
##############

If ($DefaultManagementPointProd -eq $null){
    $oCMSDev = Initialize-CapaSDK -Server $CapaServer -Database $Database
    $oCMSProd = $oCMSDev
}
else{
    $oCMSDev = Initialize-CapaSDK -Server $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointDev
    $oCMSProd = Initialize-CapaSDK -Server $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointProd
}

Get-CapaUnits -CapaSDK $oCMSDev
```

Output:

```powershell
Name           : CIKURSUS
Created        : 11-11-2021 14:24:23
LastExecuted   : 22-03-2023 19:14:03
Status         : Active
Description    :
GUID           : bc79d9fc-67d8-4221-bd81-423652ed7615
ID             : 2
TypeName       : Users
UUID           : 9401eb49-26d5-42f6-adec-edc9c1e619b8
IsMobileDevice : False
Location       : CIKURSUS.LOCAL

Name           : ADMINISTRATOR
Created        : 18-11-2021 15:11:46
LastExecuted   : 18-11-2021 15:12:45
Status         : Active
Description    :
GUID           : 883853dc-fafd-4a94-9a85-dff6e8d360e1
ID             : 6
TypeName       : Users
UUID           : 65654f58-ab21-46e1-8cfb-f3ce7aea11e8
IsMobileDevice : False
Location       : CIKURSUS.LOCAL
```
