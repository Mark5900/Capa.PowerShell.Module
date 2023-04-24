# Ini_ReadEntry
Module: Capa.PowerShell.Module.PowerPack.Ini

Reads an entry from an INI file.

## Syntax

```powershell
Ini_ReadEntry
	-FilePath <String>
	-Section <String>
	-Variable <String>
```

## Description



## Examples

### Example 1
```powershell
Ini_ReadEntry -FilePath "C:\Temp\test.ini" -Section "Section1" -Variable "Variable1"
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

The section of the INI file to read from.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Variable**

The variable to read from the INI file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455649/cs.Ini+ReadEntry
