# Service_Start
Module: Capa.PowerShell.Module.PowerPack.Service

Starts a service.

## Syntax

```powershell
Service_Start
	-ServiceName <String>
	-MaxTimeout <Object>
```

## Description



## Examples

### Example 1
```powershell
Service_Start -ServiceName "gupdate"
```
    
### Example 2
```powershell
Service_Start -ServiceName "gupdate" -MaxTimeout 120
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

The maximum timeout in seconds to wait for the service to start, default is 60 seconds.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | named | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456006/cs.Service+Start
