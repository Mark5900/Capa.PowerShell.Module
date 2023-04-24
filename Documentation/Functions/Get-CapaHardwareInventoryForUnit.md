# Get-CapaHardwareInventoryForUnit
Module: Capa.PowerShell.Module.SDK.Inventory

Get the hardware inventory for a unit.

## Syntax

```powershell
Get-CapaHardwareInventoryForUnit
	-CapaSDK <Object>
	-UnitName <String>
	-UnitType <String>
```

## Description

Get the hardware inventory for a unit.

## Examples

### Example 1
```powershell
Get-CapaHardwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer
```
    
### Example 2
```powershell
Get-CapaHardwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B' -UnitType Computer
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

Can be the name of a unit or the UUID.
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246368/Get+hardware+inventory+for+unit
