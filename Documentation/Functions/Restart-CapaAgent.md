# Restart-CapaAgent
Module: Capa.PowerShell.Module.SDK.Utilities

Sets an action to restart an agent.

## Syntax

```powershell
Restart-CapaAgent
	-CapaSDK <Object>
	-UnitName <String>
	-UnitType <String>
```

## Description

Sets an action to restart an agent.
If a user is specified, the agent on the computers linked to the user will be restarted.

## Examples

### Example 1
```powershell
Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'
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

-**UnitType**

The type of the unit. This can be either "Computer" or "User"
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247696/Restart+Agent+using+SDK
