# Sys_WaitForProcessToExist
Module: Capa.PowerShell.Module.PowerPack.Sys

Waits for a process to exist.

## Syntax

```powershell
Sys_WaitForProcessToExist
	-ProcessName <String>
	-MaxWaitSec <Int32>
	-IntervalSec <Int32>
```

## Description



## Examples

### Example 1
```powershell
Sys_WaitForProcessToExist -ProcessName "notepad.exe" -MaxWaitSec 10 -IntervalSec 1
```
    

## Parameters

-**ProcessName**

The name of the process to wait for.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**MaxWaitSec**

The maximum time to wait in seconds.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**IntervalSec**

The interval to check in seconds.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 3 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456142/cs.Sys+WaitForProcessToExist
