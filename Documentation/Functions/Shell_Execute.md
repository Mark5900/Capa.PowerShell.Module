# Shell_Execute
Module: Capa.PowerShell.Module.PowerPack.Shell

Executes a command line application.

## Syntax

```powershell
Shell_Execute
	-Command <String>
	-Arguments <String>
	-Wait <Boolean>
	-WindowStyle <Object>
	-MustExist <Boolean>
	-WorkingDirectory <String>
```

## Description



## Examples


## Parameters

-**Command**

The command to execute.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Arguments**

The arguments to pass to the command.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Wait**

Wait for the command to finish before returning.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**WindowStyle**

The window style to use when executing the command, default is 'Hidden'.
Optional values are 'Hidden', 'Normal', 'Minimized', 'Maximized'.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 4 | 
| Default value: | Hidden | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**MustExist**

Indicates if the command must exist, default is $false.
If set to $true you need to specify the full path to the command.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 5 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**WorkingDirectory**

The working directory for the command, default is empty.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes


