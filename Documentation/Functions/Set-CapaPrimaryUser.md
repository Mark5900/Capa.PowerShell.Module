# Set-CapaPrimaryUser
Module: Capa.PowerShell.Module.SDK.User

Set the primary user on a unit.

## Syntax

```powershell
Set-CapaPrimaryUser
	-CapaSDK <Object>
	-Uuid <String>
	-UserIdentifier <String>
```

## Description

Set the primary user on a unit.

## Examples

### Example 1
```powershell
Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4' -UserIdentifier 'tbs'
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

-**Uuid**

The UUID of the unit or device.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UserIdentifier**

The user that you want to set as primary on the unit, format accepted:
	SID: S-1-5-21-2955346805-1668228357-4012311724-500
	UPN: tbs@capasystems.com
	Name: tbs
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247714/Set+Primary+User
