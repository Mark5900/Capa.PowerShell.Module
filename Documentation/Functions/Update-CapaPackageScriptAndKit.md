# Update-CapaPackageScriptAndKit
Module: Capa.PowerShell.Module.SDK.Package

Use this function to update a package script and kit in Capa.

## Syntax

```powershell
Update-CapaPackageScriptAndKit
	-PackageName <String>
	-PackageVersion <String>
	-ScriptContent <String>
	-ScriptType <String>
	-PackageType <String>
	-PackageBasePath <String>
	-KitFolderPath <String>
```
```powershell
Update-CapaPackageScriptAndKit
	-PackageName <String>
	-PackageVersion <String>
	-ScriptContent <String>
	-ScriptType <String>
	-PackageType <String>
	-PackageBasePath <String>
	-SqlServerInstance <String>
	-Database <String>
	-Credential <PSCredential>
	-KitFolderPath <String>
```
```powershell
Update-CapaPackageScriptAndKit
	-PackageName <String>
	-PackageVersion <String>
	-ScriptContent <String>
	-ScriptType <String>
	-PackageType <String>
	-PackageBasePath <String>
```
```powershell
Update-CapaPackageScriptAndKit
	-PackageName <String>
	-PackageVersion <String>
	-ScriptContent <String>
	-ScriptType <String>
	-PackageType <String>
	-SqlServerInstance <String>
	-Database <String>
	-Credential <PSCredential>
```
```powershell
Update-CapaPackageScriptAndKit
	-PackageName <String>
	-PackageVersion <String>
	-PackageBasePath <String>
	-KitFolderPath <String>
```

## Description

Use this function to update a package script and kit in Capa.
You will need SqlServer module installed if you want to update a PowerPack script.

## Examples

### Example 1
```powershell
$ScriptContent = Get-Content -Path 'C:\Users\CIKursus\Downloads\InstallScript.ps1' | Out-String
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent $ScriptContent -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database
```
    
### Example 2
```powershell
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database
```
    
### Example 3
```powershell
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database
```
    
### Example 4
```powershell
Update-CapaPackageScriptAndKit -PackageName 'Test1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'PowerPack' -SqlServerInstance $CapaServer -Database $Database -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit'
```
    
### Example 5
```powershell
Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Install' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'
```
    
### Example 6
```powershell
Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -ScriptContent "Write-Host 'Hello World'" -ScriptType 'Uninstall' -PackageType 'VBScript' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs'
```
    
### Example 7
```powershell
Update-CapaPackageScriptAndKit -PackageName 'Opgave 1' -PackageVersion 'v1.0' -PackageBasePath 'D:\CapaInstaller\CMPProduction\ComputerJobs' -KitFolderPath 'C:\Users\CIKursus\Downloads\Kit\'
```
    

## Parameters

-**PackageName**

The name of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScriptContent**

The content of the script.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScriptType**

The type of the script. Valid values are: Install, Uninstall, UserConfiguration.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of the package. Valid values are: PowerPack, VBScript.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageBasePath**

The path to the package folder. Example: \\CISRVKURSUS.CIKURSUS.local\CMPProduction\ComputerJobs
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SqlServerInstance**

The name of the SQL Server instance.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Database**

The name of the database.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Credential**

The credentials to use when connecting to the SQL Server instance.
Default is to use the current user's credentials.
| Name | Value |
| ---- | ---- |
| Type: | PSCredential |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**KitFolderPath**

The path to the folder containing files to set as kit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

This is a custom function that is not part of the CapaSDK
