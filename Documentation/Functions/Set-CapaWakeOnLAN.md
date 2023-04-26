# Set-CapaWakeOnLAN
Module: Capa.PowerShell.Module.SDK.Utilities

Set a action to perform a Wake On LAN Request for the unit.

## Syntax

```powershell
Set-CapaWakeOnLAN
	-CapaSDK <Object>
	-UnitName <String>
```

## Description

Set a action to perform a Wake On LAN Request for the unit.

## Examples

### Example 1
```powershell
Set-CapaWakeOnLAN -CapaSDK $CapaSDK -UnitName 'TestComputer'
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

-**UnitName**

The name of the unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247774/Set+Wake+On+LAN
