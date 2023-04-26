# Set-CapaCustomInventory
Module: Capa.PowerShell.Module.SDK.Inventory

Set custom inventory for a unit.

## Syntax

```powershell
Set-CapaCustomInventory
	-CapaSDK <Object>
	-UnitName <String>
	-UnitType <String>
	-Section <String>
	-Name <String>
	-Value <String>
	-DataType <String>
```
```powershell
Set-CapaCustomInventory
	-CapaSDK <Object>
	-Uuid <String>
	-Section <String>
	-Name <String>
	-Value <String>
	-DataType <String>
```

## Description

Set custom inventory for a unit, either by name and type or by UUID.

## Examples

### Example 1
```powershell
Set-CapaCustomInventory -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer -Section 'Antivirus' -Name 'Version' -Value '4' -DataType Integer
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

-**Section**

The inventory section.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Name**

The name of the value.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Value**

The value.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DataType**

The data type of the value, can be String, Integer, Text or Time.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory
