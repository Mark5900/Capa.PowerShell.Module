# Get-CapaReinstallStatus
Module: Capa.PowerShell.Module.SDK.Utilities

Gets the reinstall status for a unit.

## Syntax

```powershell
Get-CapaReinstallStatus
	-CapaSDK <Object>
	-UnitName <Object>
	-UnitType <Object>
```

## Description

Gets the reinstall status for a unit.

## Examples

### Example 1
```powershell
Test-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'
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
| Type: | Object |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UnitType**

The type of the unit. This can be either "Computer" or "User"
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247466/Get+reinstall+status
