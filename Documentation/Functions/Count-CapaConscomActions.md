# Count-CapaConscomActions
Module: Capa.PowerShell.Module.SDK.SystemSdk

Counts the number of conscom actions.

## Syntax

```powershell
Count-CapaConscomActions
	-CapaSDK <Object>
	-ManagementServerID <Int32>
```

## Description

Counts the number of conscom actions.

## Examples

### Example 1
```powershell
Count-CapaConscomActions -CapaSDK $CapaSDK -ManagementServerID 1
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

-**ManagementServerID**

The management server ID to check for. If omitted, conscom actions for all servers are counted.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247078/Count+conscom+actions
