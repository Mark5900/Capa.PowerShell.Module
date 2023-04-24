# Service_Stop
Module: Capa.PowerShell.Module.PowerPack.Service

Stops a service.

## Syntax

```powershell
Service_Stop
	-ServiceName <String>
	-MaxTimeout <Object>
```

## Description



## Examples

### Example 1
```powershell
Service_Stop -ServiceName "gupdate"
```
    
### Example 2
```powershell
Service_Stop -ServiceName "gupdate" -MaxTimeout 120
```
    

## Parameters

-**ServiceName**

The name of the service.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**MaxTimeout**

The maximum timeout in seconds to wait for the service to stop, default is 60 seconds.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456023/cs.Service+Stop
