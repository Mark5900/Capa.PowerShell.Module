# Remove-CapaPackageFromManagementServer
Module: Capa.PowerShell.Module.SDK.Package

Removes a package from a management server.

## Syntax

```powershell
Remove-CapaPackageFromManagementServer
	-CapaSDK <Object>
	-PackageName <String>
	-PackageVersion <String>
	-PackageType <String>
	-ServerName <String>
```

## Description

Removes a package from a management server.

## Examples

### Example 1
```powershell
Remove-CapaPackageFromManagementServer -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -ServerName 'MyServer'
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

The name of the package to remove from the management server.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package to remove from the management server.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of package to remove from the management server.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ServerName**

The name of the management server to remove the package from.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247016/Remove+package+from+management+server
