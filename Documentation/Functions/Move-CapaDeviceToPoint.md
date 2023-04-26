# Move-CapaDeviceToPoint
Module: Capa.PowerShell.Module.SDK.Utilities

Moves a device from its current Management Point to the specified Management Point.

## Syntax

```powershell
Move-CapaDeviceToPoint
	-CapaSDK <Object>
	-DeviceUUID <Object>
	-PointName <Object>
	-ManagementServerFQDN <Object>
```

## Description

Moves a device from its current Management Point to the specified Management Point. If a Management Server is specified, the device will be linked to it.

All relations to the device in the old Management Point will be removed, including but not limited to packages, profiles, applications, groups, folders, primary user, user relations, management server.

## Examples

### Example 1
```powershell
Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'TestManagementPoint' -ManagementServerFQDN 'TestManagementServer'
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

-**DeviceUUID**

The UUID of the device.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PointName**

The name of the Management Point the device should be moved to.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ManagementServerFQDN**

The name of the Management Server the device should be linked to. If an empty string is specified, the device will not be linked to a Management Server after the move.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247640/Move+Device+To+Management+Point
