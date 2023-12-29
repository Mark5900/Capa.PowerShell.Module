# Exit-PpCommandObsolete
Module: Capa.PowerShell.Module.PowerPack.Exit

Set error code that the command is obsolete.

## Syntax

```powershell
Exit-PpCommandObsolete
	-ExitMessage <String>
```

## Description

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## Examples

### Example 1
```powershell
Exit-PpCommandObsolete
```
    
### Example 2
```powershell
Exit-PpCommandObsolete -ExitMessage "This command is obsolete."
```
    

## Parameters

-**ExitMessage**

Exit message to display.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom command.
