# Rebuild-CapaKitFileOnManagementServer
Module: Capa.PowerShell.Module.SDK.SystemSdk

Rebuilds CapaInstaller.kit file on Management Server.

## Syntax

```powershell
Rebuild-CapaKitFileOnManagementServer
	-CapaSDK <Object>
	-PackageName <String>
	-PackageVersion <String>
	-PackageType <String>
	-ServerName <String>
```

## Description

Rebuilds CapaInstaller.kit file on Management Server. The function sets an action for the assigned Replicator to perform.

## Examples

### Example 1
```powershell
Rebuild-CapaKitFileOnManagementServer -CapaSDK $CapaSDK -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer' -ServerName 'MS1'
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

-**PackageName**

The name of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ServerName**

The management server to which the package is to be added to.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247144/Rebuild+kit+on+Management+Server
