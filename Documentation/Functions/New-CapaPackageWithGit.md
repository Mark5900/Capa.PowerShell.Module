# New-CapaPackageWithGit
Module: Capa.PowerShell.Module.SDK.Package

Create a new Capa package with Git

## Syntax

```powershell
New-CapaPackageWithGit
	-PackageName <String>
	-PackageVersion <String>
	-PackageType <String>
	-BasePath <String>
	-CapaServer <Object>
	-SQLServer <Object>
	-Database <Object>
	-DefaultManagementPoint <Object>
	-PackageBasePath <Object>
```

## Description

Creates a local folder structure you can use with Git to manage your deployment of Capa packages.
The folder structure is based on the Capa package structure.

## Examples

### Example 1
```powershell
New-CapaPackageWithGit -PackageName 'Test' -PackageVersion 'v1.0' -PackageType 'VBScript' -BasePath 'D:\PowerShell'
```
    
### Example 2
```powershell
New-CapaPackageWithGit -PackageName 'Test2' -PackageVersion 'v1.0' -PackageType 'PowerPack' -BasePath 'D:\PowerShell' -CapaServer $CapaServer -Database $Database -DefaultManagementPoint $DefaultManagementPointDev
```
    

## Parameters

-**PackageName**

The name of the package
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of the package. Valid values are VBScript and PowerPack
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BasePath**

The base path where the package folder will be created
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**CapaServer**

The name of the Capa server
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SQLServer**


| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Database**

The name of the Capa database
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DefaultManagementPoint**

The default management point in Capa it should be set to the id of the development management point.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 8 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageBasePath**


| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 9 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

This is a custom function for Capa. It is not part of the Capa SDK.
