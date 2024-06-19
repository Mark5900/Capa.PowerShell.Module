# New-CapaPowerPack
Module: Capa.PowerShell.Module.SDK.Package

Creates a new PowerPack in CapaInstaller

## Syntax

```powershell
New-CapaPowerPack
	-CapaSDK <PSObject>
	-PackageName <String>
	-PackageVersion <String>
	-DisplayName <String>
	-InstallScriptContent <String>
	-UninstallScriptContent <String>
	-KitFolderPath <String>
	-ChangelogComment <String>
	-SqlServerInstance <String>
	-Database <String>
	-Credential <PSCredential>
	-PointID <Int32>
	-AllowInstallOnServer <Boolean>
```

## Description

Creates a new PowerPack in CapaInstaller using the CapaSDK and the SqlServer module

## Examples

### Example 1
```powershell
New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -SqlServerInstance $CapaServer -Database $Database
```
    
### Example 2
```powershell
New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -InstallScriptContent 'Write-Host "Hello World"' -SqlServerInstance $CapaServer -Database $Database
```
    
### Example 3
```powershell
New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -KitFolderPath 'C:\Temp\Kit' -SqlServerInstance $CapaServer -Database $Database
```
    
### Example 4
```powershell
New-CapaPowerPack -CapaSDK $oCMSDev -PackageName 'Test1' -PackageVersion 'v1.0' -DisplayName 'Test1' -KitFolderPath 'C:\Temp\Kit' -SqlServerInstance $CapaServer -Database $Database -PointID 1
```
    

## Parameters

-**CapaSDK**

The CapaSDK object
| Name | Value |
| ---- | ---- |
| Type: | PSObject |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageName**

The name of the package
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DisplayName**

The display name of the package, if not specified then the package name and version will be used
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | "$PackageName $PackageVersion" | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**InstallScriptContent**

The install script content of the package, if not specified then the default install script will be used
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UninstallScriptContent**

The uninstall script content of the package, if not specified then the default uninstall script will be used
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**KitFolderPath**

The path to the kit folder, if not specified then a dummy kit folder will be created
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

The changelog comment of the package
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 8 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SqlServerInstance**

The SQL Server instance
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 9 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Database**

The Capa database name
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 10 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Credential**

The SQL Server credential
| Name | Value |
| ---- | ---- |
| Type: | PSCredential |
| Position: | 11 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PointID**

The ID of the point to rebuild the kit file on, if not specified then the kit file will not be rebuilt.
Requires that KitFolderPath is specified.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 12 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowInstallOnServer**

Allow the package to be installed on the server
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 13 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes


