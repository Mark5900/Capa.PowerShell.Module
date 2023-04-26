# Get-CapaWSUSGroupUnits
Module: Capa.PowerShell.Module.SDK.WSUS

Gets a list of units linked to a WSUS group.

## Syntax

```powershell
Get-CapaWSUSGroupUnits
	-CapaSDK <Object>
	-WSUSGroupName <String>
```

## Description

Gets a list of units linked to a WSUS group.

## Examples

### Example 1
```powershell
Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName "WSUS Group"
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

-**WSUSGroupName**

The name of the WSUS group.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247622/Get+WSUS+Group+units
