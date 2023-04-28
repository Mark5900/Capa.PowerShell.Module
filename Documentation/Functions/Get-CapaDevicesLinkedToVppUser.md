# Get-CapaDevicesLinkedToVppUser
Module: Capa.PowerShell.Module.SDK.VPP

Gets a list of devices linked to a VPP user.

## Syntax

```powershell
Get-CapaDevicesLinkedToVppUser
	-CapaSDK <Object>
	-vppUserID <Int32>
```

## Description

Gets a list of devices linked to a VPP user.

## Examples

### Example 1
```powershell
Get-CapaDevicesLinkedToVppUser -CapaSDK $CapaSDK -vppUserID 1
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

-**vppUserID**

The ID of the VPP user.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247426/Get+devices+linked+to+vpp+user
