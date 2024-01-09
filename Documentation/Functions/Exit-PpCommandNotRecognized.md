# Exit-PpCommandNotRecognized
Module: Capa.PowerShell.Module.PowerPack.Exit

Set error code that the command is not recognized.

## Syntax

```powershell
Exit-PpCommandNotRecognized
	-ExitMessage <String>
```

## Description

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## Examples

### Example 1
```powershell
Exit-PpCommandNotRecognized
```
    
### Example 2
```powershell
Exit-PpCommandNotRecognized -ExitMessage "The command was not recognized."
```
    

## Parameters

-**ExitMessage**

Exit message to be displayed.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom command.
