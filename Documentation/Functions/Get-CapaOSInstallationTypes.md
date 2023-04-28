# Get-CapaOSInstallationTypes
Module: Capa.PowerShell.Module.SDK.OSDeployment

Get a list of OS Installation Types.

## Syntax

```powershell
Get-CapaOSInstallationTypes
	-CapaSDK <Object>
	-OSPointID <Int32>
```

## Description

Get a list of OS Installation Types.

## Examples

### Example 1
```powershell
Get-CapaOSInstallationTypes -CapaSDK $CapaSDK -OSPointID 1
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246688/Get+OS+installation+types
