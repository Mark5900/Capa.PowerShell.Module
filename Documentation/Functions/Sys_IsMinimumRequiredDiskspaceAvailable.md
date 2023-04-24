# Sys_IsMinimumRequiredDiskspaceAvailable
Module: Capa.PowerShell.Module.PowerPack.Sys

Checks if a minimum required disk space is available.

## Syntax

```powershell
Sys_IsMinimumRequiredDiskspaceAvailable
	-Drive <String>
	-MinimumRequiredDiskspaceInMb <Int32>
```

## Description



## Examples

### Example 1
```powershell
Sys_IsMinimumRequiredDiskspaceInMbAvailable -MinimumRequiredDiskspaceInMb 1000
```
    
### Example 2
```powershell
Sys_IsMinimumRequiredDiskspaceInMbAvailable -Drive "D:" -MinimumRequiredDiskspaceInMb 1000
```
    

## Parameters

-**Drive**

The drive to check, default is 'C:'.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | C: | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**MinimumRequiredDiskspaceInMb**

The minimum required disk space in bytes.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456108/cs.Sys+IsMinimumRequiredDiskspaceAvailable
