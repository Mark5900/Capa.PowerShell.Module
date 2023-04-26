# Get-CapaUserInventory
Module: Capa.PowerShell.Module.SDK.Inventory

Get software inventory for a user.

## Syntax

```powershell
Get-CapaUserInventory
	-CapaSDK <Object>
	-UserName <Object>
```

## Description

Get software inventory for a user.

## Examples

### Example 1
```powershell
Get-CapaSoftwareInventoryForUser -CapaSDK $CapaSDK -UserName 'Klient'
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

-**UserName**

The username of the user.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246418/Get+User+Inventory
