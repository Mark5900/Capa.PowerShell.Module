# Get-CapaGroups
Module: Capa.PowerShell.Module.SDK.Group

Get groups.

## Syntax

```powershell
Get-CapaGroups
	-CapaSDK <Object>
	-GroupType <String>
	-BusinessUnit <String>
```

## Description

Get either all groups or from all groups from specific business unit.

## Examples

### Example 1
```powershell
Get-CapaGroups -CapaSDK $CapaSDK
```
    
### Example 2
```powershell
Get-CapaGroups -CapaSDK $CapaSDK -GroupType Dynamic_ADSI
```
    

## Parameters

-**CapaSDK**

CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**GroupType**


| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**BusinessUnit**

If specified, only groups from this business unit will be returned.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246280/Get+groups 		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246290/Get+groups+on+Business+Unit
