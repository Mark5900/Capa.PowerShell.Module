# Get-CapaVppUsers
Module: Capa.PowerShell.Module.SDK.VPP

Gets a list of all VPP users.

## Syntax

```powershell
Get-CapaVppUsers
	-CapaSDK <Object>
	-VppProgramID <Int32>
```

## Description

Gets a list of all VPP users, if VppProgramID is specified, only VPP users for the specified program will be returned.

## Examples

### Example 1
```powershell
Get-CapaVppUsers -CapaSDK $CapaSDK
```
    
### Example 2
```powershell
Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 1
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

A description of the VppProgramID parameter.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247808/Get+vpp+users 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247818/Get+vpp+users+all
