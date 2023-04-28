# Link-CapaProfileToGroup
Module: Capa.PowerShell.Module.SDK.MDM

Link an existing profile to a group.

## Syntax

```powershell
Link-CapaProfileToGroup
	-CapaSDK <Object>
	-ProfileId <Int32>
	-GroupName <String>
	-GroupType <String>
	-BusinessUnitName <String>
	-ChangelogComment <String>
```

## Description

LINK an existing profile to a group.

## Examples

### Example 1
```powershell
Link-CapaProfileToGroup -CapaSDK $CapaSDK -ProfileId 1 -GroupName 'Test Group' -GroupType 'Static'
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

The ID of the profile.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupName**

The name of the Group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupType**

The type of the Group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnitName**

The name of the Business Unit where the group is located. If en empty string is specified, the group will be found in Global.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

A comment that will be added to the changelog entry on the proifile and the group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246638/Link+profile+to+group
