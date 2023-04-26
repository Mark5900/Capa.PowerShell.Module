# Get-CapaOSDiskConfigration
Module: Capa.PowerShell.Module.SDK.OSDeployment

Gets a list of OS Disk Configurations.

## Syntax

```powershell
Get-CapaOSDiskConfigration
	-CapaSDK <Object>
	-OSPointID <Int32>
```

## Description

Gets a list of OS Disk Configurations.

## Examples

### Example 1
```powershell
Get-CapaOSDiskConfigration -CapaSDK $CapaSDK -OSPointID 1
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246664/Get+OS+disk+configurations
