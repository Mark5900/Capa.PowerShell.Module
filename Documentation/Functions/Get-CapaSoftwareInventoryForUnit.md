# Get-CapaSoftwareInventoryForUnit
Module: Capa.PowerShell.Module.SDK.Inventory

Get software inventory for a unit.

## Syntax

```powershell
Get-CapaSoftwareInventoryForUnit
	-CapaSDK <Object>
	-UnitName <String>
	-UnitType <String>
```
```powershell
Get-CapaSoftwareInventoryForUnit
	-CapaSDK <Object>
	-UnitType <String>
	-Uuid <String>
```

## Description

Get software inventory for a unit.

## Examples

### Example 1
```powershell
Get-CapaSoftwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer
```
    
### Example 2
```powershell
Get-CapaSoftwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B' -UnitType Computer
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

The type of the unit, can be Computer or User.
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246398/Get+software+inventory+for+unit
