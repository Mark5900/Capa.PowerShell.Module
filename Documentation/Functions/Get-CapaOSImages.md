# Get-CapaOSImages
Module: Capa.PowerShell.Module.SDK.OSDeployment

Gets a list of OS Images.

## Syntax

```powershell
Get-CapaOSImages
	-CapaSDK <Object>
	-OSPointID <Int32>
```

## Description

Gets a list of OS Images.

## Examples

### Example 1
```powershell
Get-CapaOSImages -CapaSDK $CapaSDK -OSPointID 1
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

-**OSPointID**

The ID of the OS Point.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246676/Get+OS+images
