# Get-CapaManagementPoint
Module: Capa.PowerShell.Module.SDK.SystemSdk

Get management points or a specific management point.

## Syntax

```powershell
Get-CapaManagementPoint
	-CapaSDK <Object>
	-CmpId <Int32>
```

## Description

If CmpId is not specified, all management points are returned.

## Examples

### Example 1
```powershell
Get-CapaManagementPoint -CapaSDK $value1 -CmpId $value2
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

-**CmpId**

The ID of the management point to return. If omitted, all management points are returned.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247106/Get+management+point 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247116/Get+management+points
