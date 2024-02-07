# New-CapaPackageWithGit
Module: Capa.PowerShell.Module.SDK.Package

Creates a new capa package with Git support

## Syntax

```powershell
New-CapaPackageWithGit
	-PackageName <String>
	-PackageVersion <String>
	-PackageType <String>
	-BasePath <String>
	-CapaServer <String>
	-SQLServer <String>
	-Database <String>
	-DefaultManagementPoint <String>
	-PackageBasePath <String>
```
```powershell
New-CapaPackageWithGit
	-SoftwareName <String>
	-SoftwareVersion <String>
	-PackageType <String>
	-BasePath <String>
	-CapaServer <String>
	-SQLServer <String>
	-Database <String>
	-DefaultManagementPoint <String>
	-PackageBasePath <String>
	-Advanced <>
```

## Description

Creates a local folder structure you can use with Git to manage your deployment of Capa packages.
There is both a simple and advanced mode.

It is recommended to read the documentation before using this function. https://github.com/Mark5900/Capa.PowerShell.Module/tree/main/Documentation

## Examples

### Example 1
```powershell
New-CapaPackageWithGit -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'VBScript' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs'
```
    
### Example 2
```powershell
New-CapaPackageWithGit -SoftwareName 'Test1' -SoftwareVersion 'v1.0' -PackageType 'PowerPack' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs' -Advanced
```
    

## Parameters

-**PackageName**

The name of the package
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SoftwareName**

The name of the software
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SoftwareVersion**

The version of the software
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of the package, either VBScript or PowerPack
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BasePath**

The base path where the package folder will be created
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**CapaServer**

The Capa server name
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SQLServer**

The SQL server name
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Database**

The Capa database name
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DefaultManagementPoint**

The default management point
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageBasePath**

The path of where CapaInstaller is saving the packages, example E:\CapaInstaller\CMPProduction\ComputerJobs
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Advanced**

When specified the advanced setup will be used
| Name | Value |
| ---- | ---- |
| Type: | SwitchParameter |
| Position: | named | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

This is a custom function that is not part of the CapaSDK
