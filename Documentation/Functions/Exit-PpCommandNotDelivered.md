# Exit-PpCommandNotDelivered
Module: Capa.PowerShell.Module.PowerPack.Exit

Set error code that the command was not delivered.

## Syntax

```powershell
Exit-PpCommandNotDelivered
	-ExitMessage <String>
```

## Description

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## Examples

### Example 1
```powershell
Exit-PpCommandNotDelivered
```
    
### Example 2
```powershell
Exit-PpCommandNotDelivered -ExitMessage 'The command was not delivered.'
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
