# Start-ScriptLogging
Module: Capa.PowerShell.Module.SDK.Utilities

This fuction is used to start logging of a SDK script.

## Syntax

```powershell
Start-ScriptLogging
	-Path <String>
	-UseDateInFileName <Boolean>
	-UseTimeInFileName <Boolean>
	-UseStopwatch <Boolean>
	-DeleteDaysOldLogs <Int32>
	-LogName <String>
	-DeleteAllLogs <Boolean>
	-AppendToLog <Boolean>
```

## Description

This fuction is used to start logging of a SDK script.
The log file will be stored in a folder named Logs_<LogName> in the path specified.
You can get the path to the log file by using the global variable $Global:SDKScriptLogfile.

## Examples

### Example 1
```powershell
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module'
```
    
### Example 2
```powershell
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseDateInFileName False
```
    
### Example 3
```powershell
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseTimeInFileName False
```
    
### Example 4
```powershell
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseStopwatch False
```
    
### Example 5
```powershell
Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -DeleteDaysOldLogs 1
```
    

## Parameters

-**Path**

Defines the path to the folder where the log file should be stored.
In most cases this should be $PSScriptRoot.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseDateInFileName**

Default is true. If set to false the date will not be used in the log file name.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 2 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseTimeInFileName**

Default is true. If set to false the time will not be used in the log file name.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseStopwatch**

Default is true. If set to false the stopwatch will not be used in the log file.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 4 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DeleteDaysOldLogs**

Sets the number of days old logs should be deleted.
Default is 90 days.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 5 | 
| Default value: | 90 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**LogName**

Sets the name of the log file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DeleteAllLogs**

Default is false. If set to true all logs will be deleted.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 7 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AppendToLog**

Default is true. If set to false a new log file will be created.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 8 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

This is a custom function created to have a standard way of starting logging in SDK scripts.
