# Exit-PpRetryLater
Module: Capa.PowerShell.Module.PowerPack.Exit

Set package retry later.

## Syntax

```powershell
Exit-PpRetryLater
	-ExitMessage <String>
```

## Description

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package retry later.

## Examples

### Example 1
```powershell
Exit-PpRetryLater
```
    
### Example 2
```powershell
Exit-PpRetryLater -ExitMessage 'Test where I set ExitMessage'
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
