# Get-CapaUpdateInventoryForUnit
Module: Capa.PowerShell.Module.SDK.Inventory

Get update inventory for a unit.

## Syntax

```powershell
Get-CapaUpdateInventoryForUnit
	-CapaSDK <Object>
	-UnitName <String>
	-UnitType <String>
```

## Description

Get a list of update inventory for a unit.

## Examples

### Example 1
```powershell
Get-CapaUpdateInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer
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

The name of the unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitType**

The type of the unit, can be Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246408/Get+update+inventory+for+unit
