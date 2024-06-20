# Write-LogLine
Module: Capa.PowerShell.Module.SDK.Utilities

Use to write a line to the log file.

## Syntax

```powershell
Write-LogLine
	-Text <String>
	-ScriptPart <String>
	-ForegroundColor <Object>
```

## Description

Used to write a  pretty line to the log file indstead of using Write-Host or Write-Output.

## Examples

### Example 1
```powershell
Write-LogLine -Text 'value1'
```
    
### Example 2
```powershell
Write-LogLine -Text 'value1' -ScriptPart 'Function1'
```
    
### Example 3
```powershell
Write-LogLine -Text 'value1' -ScriptPart 'Function1' -ForegroundColor 'Red'
```
    

## Parameters

-**Text**

The text to write to the log file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScriptPart**

The part of the script that is writing to the log file.
Default value is 'Main'.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | Main | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ForegroundColor**

The color of the text.
Only usable to see in the console.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 3 | 
| Default value: | (Get-Host).ui.rawui.ForegroundColor | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

This is a custom function created to have a standard way of starting logging in SDK scripts.
