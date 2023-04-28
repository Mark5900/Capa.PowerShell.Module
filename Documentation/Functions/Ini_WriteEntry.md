# Ini_WriteEntry
Module: Capa.PowerShell.Module.PowerPack.Ini

Writes an entry to an INI file.

## Syntax

```powershell
Ini_WriteEntry
	-FilePath <String>
	-Section <String>
	-Variable <String>
	-Value <String>
```

## Description



## Examples

### Example 1
```powershell
Ini_WriteEntry -FilePath "C:\Temp\test.ini" -Section "Section1" -Variable "Variable1" -Value "Value1"
```
    

## Parameters

-**FilePath**

The path to the INI file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Section**

The section of the INI file to write to.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Variable**

The variable to write to the INI file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Value**

The value to write to the INI file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455666/cs.Ini+WriteEntry
