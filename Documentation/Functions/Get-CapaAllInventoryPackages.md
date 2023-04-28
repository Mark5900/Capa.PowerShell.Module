# Get-CapaAllInventoryPackages
Module: Capa.PowerShell.Module.SDK.Package

Gets all inventory packages.

## Syntax

```powershell
Get-CapaAllInventoryPackages
	-CapaSDK <Object>
	-PackageType <String>
```

## Description

Gets all inventory packages.

## Examples

### Example 1
```powershell
Get-CapaAllInventoryPackages -CapaSDK $CapaSDK -PackageType 'Computer'
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246890/Get+all+inventory+packages
