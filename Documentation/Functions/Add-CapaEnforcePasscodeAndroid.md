# Add-CapaEnforcePasscodeAndroid
Module: Capa.PowerShell.Module.SDK.MDM

Add a new Enforce Passcode payload or edit an existing one.

## Syntax

```powershell
Add-CapaEnforcePasscodeAndroid
	-CapaSDK <Object>
	-ProfileId <Int32>
	-Passcode <String>
	-ChangelogComment <Object>
```

## Description

Add a new Enforce Passcode payload or edit an existing payload in the specified profile.

## Examples

### Example 1
```powershell
Add-CapaEnforcePasscodeAndroid -CapaSDK $CapaSDK -ProfileId 1 -Passcode '12345678' -ChangelogComment 'Adding Enforce Passcode payload to profile'
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

The ID of the profile to add the payload to.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Passcode**

The passcode to enforce.
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
| Type: | Object |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246520/Add+edit+Enforce+Passcode+Android
