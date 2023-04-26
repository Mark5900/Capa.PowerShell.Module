# Remove-CapaGroup
Module: Capa.PowerShell.Module.SDK.Group

Removes a group.

## Syntax

```powershell
Remove-CapaGroup
	-CapaSDK <Object>
	-GroupName <String>
	-GroupType <String>
	-UnitType <String>
	-BusinessUnit <String>
```

## Description

Removes a group either from a business unit or from global.

## Examples

### Example 1
```powershell
Remove-CapaGroup -CapaSDK $CapaSDK -GroupName 'Lenovo' -GroupType Static -UnitType Computer
```
    
### Example 2
```powershell
Remove-CapaGroup -CapaSDK $CapaSDK -GroupName 'Lenovo' -GroupType Static -UnitType Computer -BusinessUnit 'Test'
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

-**UnitType**

The type of the unit in the group, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnit**

If specified, the group will be removed in this business unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246248/Delete+Group+in+Business+Unit
