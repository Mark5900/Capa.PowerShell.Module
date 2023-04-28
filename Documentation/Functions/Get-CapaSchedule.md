# Get-CapaSchedule
Module: Capa.PowerShell.Module.SDK.Container

Returns a schedule object by id.

## Syntax

```powershell
Get-CapaSchedule
	-CapaSDK <Object>
	-Id <String>
```

## Description

Will return something like this: 5|06-01-2011 12:00:00||0|00:00:00|1.00:00:00|Periodical|RecurEvery[1] weeks on [Monday-Tuesday-Wednesday-Thursday-Friday-Saturday-Sunday]|Weekly||True||842b2894-cdab-4a2c-905c-17ee052179db

## Examples

### Example 1
```powershell
Get-CapaSchedule -CapaSDK $CapaSDK -Id '5'
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

-**Id**

Id of the requested unit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246132/Get+schedule
