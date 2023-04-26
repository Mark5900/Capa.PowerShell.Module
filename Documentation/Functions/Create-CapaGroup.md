# Create-CapaGroup
Module: Capa.PowerShell.Module.SDK.Group

Create a group.

## Syntax

```powershell
Create-CapaGroup
	-CapaSDK <Object>
	-GroupName <String>
	-GroupType <String>
	-UnitType <String>
	-BusinessUnit <String>
```

## Description

Create a group, either in global scope or in a business unit.

## Examples

### Example 1
```powershell
Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer
```
    
### Example 2
```powershell
Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer -BusinessUnit 'Denmark'
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

The type of the group, either Calendar, Department or Static.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitType**

The type of elements in the group, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnit**

The name of the business unit to create the group in, if not specified the group will be created in global scope.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246224/Create+group 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246232/Create+group+in+Business+Unit
