# Import-CapaPackage
Module: Capa.PowerShell.Module.SDK.Package

Imports a package into CapaInstaller.

## Syntax

```powershell
Import-CapaPackage
	-CapaSDK <Object>
	-FilePath <String>
	-OverrideCIPCdata <Boolean>
	-ImportFolderStructure <Boolean>
	-ImportSchedule <Boolean>
	-ChangelogComment <String>
```

## Description

Imports a package into CapaInstaller.

## Examples

### Example 1
```powershell
Import-CapaPackage -CapaSDK $value1 -FilePath 'C:\Temp\Package.zip' -OverrideCIPCdata $true -ImportFolderStructure $true -ImportSchedule $true
```
    

## Parameters

-**CapaSDK**

The CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**FilePath**

Specifies the path to the zip file containing the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**OverrideCIPCdata**

If the zip file contains metadata used by the Package Creator, setting this to true will override these metadata if any already exists in the CMS database.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ImportFolderStructure**

Determines wether or not the folder structure will be imported from the exported package.
If this is true, the package will be placed in the folder it was located in, when it was exported. Any folders in that structure that doesn't already exist, will be created in CMS.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 4 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ImportSchedule**

Determines wether or not the schedule will be imported from the package.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 5 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

An optional comment to add to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246984/Import+package
