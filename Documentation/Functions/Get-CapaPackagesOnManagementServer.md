# Get-CapaPackagesOnManagementServer
Module: Capa.PowerShell.Module.SDK.Package

Get a list of packages on a management server.

## Syntax

```powershell
Get-CapaPackagesOnManagementServer
	-CapaSDK <Object>
	-ServerName <String>
	-PackageType <String>
```

## Description

Get a list of packages on a management server.

## Examples

### Example 1
```powershell
Get-CapaPackagesOnManagementServer -CapaSDK $CapaSDK -ServerName 'TestServer' -PackageType 'Computer'
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

-**ServerName**

The name of the management server.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of package, can be either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246974/Get+packages+on+management+server
