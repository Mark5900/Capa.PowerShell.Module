# Assign-CapaProfileToBusinessUnit
Module: Capa.PowerShell.Module.SDK.MDM

Assign a profile to a business unit.

## Syntax

```powershell
Assign-CapaProfileToBusinessUnit
	-CapaSDK <Object>
	-ProfileId <Int32>
	-BusinessUnitName <String>
	-ChangelogComment <String>
```

## Description

Assign a profile to a business unit.

## Examples

### Example 1
```powershell
Assign-CapaProfileToBusinessUnit -CapaSDK $CapaSDK -ProfileId 1 -BusinessUnitName 'My Business Unit' -ChangelogComment 'Assigning profile to business unit'
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

-**ProfileId**

The ID of the profile you wish to assign to a business unit.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnitName**

The name of the business unit you wish to assign the profile to.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

The comment you wish to be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246552/Assign+Profile+to+Business+Unit
