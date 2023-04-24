# Get-CapaWSUSGroups
Module: Capa.PowerShell.Module.SDK.WSUS

Gets a list of WSUS groups.

## Syntax

```powershell
Get-CapaWSUSGroups
	-CapaSDK <Object>
	-PointID <Int32>
```

## Description

Gets a list of WSUS groups.

## Examples

### Example 1
```powershell
Get-CapaWSUSGroups -CapaSDK $CapaSDK -PointID 1
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

-**PointID**

The IS of the WSUS point.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247844/Get+WSUS+Groups
