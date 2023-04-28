# Get-CapaCustomInventoryForUnit
Module: Capa.PowerShell.Module.SDK.Inventory

Get the custom inventory for a unit.

## Syntax

```powershell
Get-CapaCustomInventoryForUnit
	-CapaSDK <Object>
	-UnitName <String>
	-UnitType <String>
```
```powershell
Get-CapaCustomInventoryForUnit
	-CapaSDK <Object>
	-Uuid <String>
```

## Description

Get the custom inventory for a unit, with the option to get the inventory by name and type or by UUID.

## Examples

### Example 1
```powershell
Get-CapaCustomInventoryForUnit -Uuid 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B'
```
    
### Example 2
```powershell
Get-CapaCustomInventoryForUnit -UnitName 'CAPA-TEST-01' -UnitType 'Computer'
```
    

## Parameters

-**CapaSDK**

The CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitName**

The name of the unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitType**

The type of the unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Uuid**

The UUID of the unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246358/Get+custom+inventory+for+unit
