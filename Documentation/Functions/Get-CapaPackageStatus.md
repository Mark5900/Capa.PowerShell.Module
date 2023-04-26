# Get-CapaPackageStatus
Module: Capa.PowerShell.Module.SDK.Package

Gets a list of packages and their status on a unit.

## Syntax

```powershell
Get-CapaPackageStatus
	-CapaSDK <Object>
	-UnitName <String>
	-UnitType <String>
```

## Description

Gets a list of packages and their status on a unit.

## Examples

### Example 1
```powershell
Get-CapaPackageStatus -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer
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

-**UnitName**

The name of the unit, can also be the UUID.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitType**

The type of unit, can be either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246944/Get+package+status
