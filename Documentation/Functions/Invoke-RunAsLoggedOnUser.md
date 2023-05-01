# Invoke-RunAsLoggedOnUser
Module: Capa.PowerShell.Module.PowerPack

Runs a command as the logged on user.

## Syntax

```powershell
Invoke-RunAsLoggedOnUser
	-Command <String>
	-UserName <String>
	-Arguments <String>
```

## Description

Runs a command as the logged on user, by creating a scheduled task and starting it.

## Examples

### Example 1
```powershell
Invoke-RunAsLoggedOnUser -Command 'C:\Temp\MyApp.exe' -Arguments '/silent' -UserName 'MyDomain\MyUser'
```
    

## Parameters

-**Command**

The command to run.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UserName**

The user name to run the command as.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Arguments**

The arguments to pass to the command.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Command from PSlib.psm1
