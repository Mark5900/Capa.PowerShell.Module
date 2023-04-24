# Invite-CapaUnitToVppProgram
Module: Capa.PowerShell.Module.SDK.VPP

Creates a VPP user at Apple where an invitation URL is generated. This invitation is then sent to the device where the user will have the option to accept or decline.

## Syntax

```powershell
Invite-CapaUnitToVppProgram
	-CapaSDK <Object>
	-VppProgramID <Int32>
	-UnitID <Int32>
	-UserFullName <String>
	-UserEmailName <String>
	-UserDescription <String>
```

## Description

Creates a VPP user at Apple where an invitation URL is generated. This invitation is then sent to the device where the user will have the option to accept or decline.
If the user accepts the invitation, its Apple ID will be linked to the VPP user at Apple, which can be seen in the system after the next synchronization cycle.

There are a few requirements for the operation to succeed.
	The device must be running iOS8 or higher.
	The device should not already be enrolled in the Volume Purchase Program specified.
	If an invitation previously sent to the device was not accepted, a VPP user will already exist at Apple. In order to avoid creating multiple VPP users, the system will reuse that original invitation and send it to the device again.

## Examples

### Example 1
```powershell
Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 1 -UserFullName 'Test User' -UserEmailName 'Test@test.com' -UserDescription 'Test User'
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

-**VppProgramID**

The VPP user will be created in the program with the specified id.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitID**

The id of the iOS device which should receive an invitation.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 3 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UserFullName**

The fullname of the vpp user being created.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UserEmailName**

The email of the vpp user being created.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UserDescription**

The description of the vpp user being created.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247828/Invite+unit+to+vpp
