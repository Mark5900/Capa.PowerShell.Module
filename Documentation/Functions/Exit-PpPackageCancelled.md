# Exit-PpPackageCancelled
Module: Capa.PowerShell.Module.PowerPack.Exit

Set error code that the package is cancelled.

## Syntax

```powershell
Exit-PpPackageCancelled
	-ExitMessage <String>
```

## Description

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## Examples

### Example 1
```powershell
Exit-PpPackageCancelled
```
    
### Example 2
```powershell
Exit-PpPackageCancelled -ExitMessage 'Test where I set ExitMessage'
```
    

## Parameters

-**ExitMessage**


| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom command.
