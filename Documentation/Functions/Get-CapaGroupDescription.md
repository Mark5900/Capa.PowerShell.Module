# Get-CapaGroupDescription
Module: Capa.PowerShell.Module.SDK.Group

Get a groups description.

## Syntax

```powershell
Get-CapaGroupDescription
	-CapaSDK <Object>
	-GroupName <String>
	-GroupType <String>
```

## Description

Returns a string with the description of the group.

## Examples

### Example 1
```powershell
Get-CapaGroupDescription -CapaSDK $CapaSDK -GroupName 'Default' -GroupType Static
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246264/Get+Group+Description
