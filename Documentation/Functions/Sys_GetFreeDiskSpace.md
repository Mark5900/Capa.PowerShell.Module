# Sys_GetFreeDiskSpace
Module: Capa.PowerShell.Module.PowerPack.Sys

Gets the free disk space of a drive.

## Syntax

```powershell
Sys_GetFreeDiskSpace
	-Drive <String>
```

## Description



## Examples

### Example 1
```powershell
Sys_GetFreeDiskSpace
```
    
### Example 2
```powershell
Sys_GetFreeDiskSpace -Drive "D:"
```
    

## Parameters

-**Drive**

The drive to get the free disk space from, default is 'C:'.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | C: | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456057/cs.Sys+GetFreeDiskSpace
