# Clear-CapaPrimaryUser
Module: Capa.PowerShell.Module.SDK.User

Clear the primary user on a unit.

## Syntax

```powershell
Clear-CapaPrimaryUser
	-CapaSDK <Object>
	-Uuid <String>
```

## Description

Clear the primary user on a unit.

## Examples

### Example 1
```powershell
Clear-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4'
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

-**Uuid**

The UUID of the unit or device.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247356/Clear+Primary+User
