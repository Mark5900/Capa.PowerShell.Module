# Get-CapatAllNoneInventoryPackages
Module: Capa.PowerShell.Module.SDK.Package

Returns all none inventory packages.

## Syntax

```powershell
Get-CapatAllNoneInventoryPackages
	-CapaSDK <Object>
	-PackageType <String>
```

## Description

Returns all none inventory packages.

## Examples

### Example 1
```powershell
Get-CapatAllNoneInventoryPackages -CapaSDK $CapaSDK -PackageType 'Computer'
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

-**PackageType**

The type of the package, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246900/Get+all+none+inventory+packages
