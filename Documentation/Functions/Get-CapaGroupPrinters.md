# Get-CapaGroupPrinters
Module: Capa.PowerShell.Module.SDK.Group

Returns printers linked to a group.

## Syntax

```powershell
Get-CapaGroupPrinters
	-CapaSDK <Object>
	-GroupName <String>
	-GroupType <String>
```

## Description

Returns array of printers linked to a group.

## Examples

### Example 1
```powershell
Get-CapaGroupPrinters -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
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

-**GroupName**

The name of the group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupType**

The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247436/Get+group+Printers
