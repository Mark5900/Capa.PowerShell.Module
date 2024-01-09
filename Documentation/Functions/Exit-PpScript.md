# Exit-PpScript
Module: Capa.PowerShell.Module.PowerPack.Exit

Exit the script with a given exit code and message.

## Syntax

```powershell
Exit-PpScript
	-ExitCode <Object>
	-ExitMessage <String>
```

## Description

Exit the script with a given exit code and message.

## Examples

### Example 1
```powershell
Exit-PpScript -ExitCode 0 -ExitMessage "Script ended successfully"
```
    
### Example 2
```powershell
Exit-PpScript -ExitCode 3305
```
    

## Parameters

-**ExitCode**

The exit code to exit the script with.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ExitMessage**

The message to write to the log before exiting the script.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Command from PSlib.psm1
