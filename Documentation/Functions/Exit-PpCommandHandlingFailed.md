# Exit-PpCommandHandlingFailed
Module: Capa.PowerShell.Module.PowerPack.Exit

Set error code that the command handling failed.

## Syntax

```powershell
Exit-PpCommandHandlingFailed
	-ExitMessage <String>
```

## Description

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## Examples

### Example 1
```powershell
Exit-PpCommandHandlingFailed
```
    
### Example 2
```powershell
Exit-PpCommandHandlingFailed -ExitMessage 'Test where I set ExitMessage'
```
    

## Parameters

-**ExitMessage**

Exit message to set.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom command.
