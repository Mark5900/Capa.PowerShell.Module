# Create-CapaProfile
Module: Capa.PowerShell.Module.SDK.MDM

Create a new profile in the Default Management Point.

## Syntax

```powershell
Create-CapaProfile
	-CapaSDK <Object>
	-Name <String>
	-Description <String>
	-Priority <Int32>
	-ChangelogComment <String>
	-BusinessUnitId <String>
```

## Description

Create a new profile in the Default Management Point. If BusinessUnitName is specified, the profile will be linked to the specified business unit.

## Examples

### Example 1
```powershell
Create-CapaProfile -CapaSDK $CapaSDK -Name 'My Profile' -Description 'My Profile Description' -Priority 1 -ChangelogComment 'Creating new profile'
```
    
### Example 2
```powershell
Create-CapaProfile -CapaSDK $CapaSDK -Name 'My Profile' -Description 'My Profile Description' -Priority 1 -ChangelogComment 'Creating new profile' -BusinessUnitName 'My Business Unit'
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

-**Name**

The name of the new profile.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Description**

The description of the new profile.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Priority**

The priority of the new profile.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 4 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

The comment you wish to be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnitId**


| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246572/Create+Profile 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246582/Create+Profile+in+Business+Unit
