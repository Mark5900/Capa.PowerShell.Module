# Get-CapaUsersLinkedToVppUser
Module: Capa.PowerShell.Module.SDK.VPP

Gets a list of users linked to a VPP user.

## Syntax

```powershell
Get-CapaUsersLinkedToVppUser
	-CapaSDK <Object>
	-VppUserID <Int32>
```

## Description

Gets a list of users linked to a vpp user, including inventory variables like full name and emails.

## Examples

### Example 1
```powershell
Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 1
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

-**VppUserID**

The ID of the VPP user.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247612/Get+users+linked+to+vpp+user
