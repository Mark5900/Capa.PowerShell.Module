# Reg_SetExpandString
Module: Capa.PowerShell.Module.PowerPack.Reg

Sets a registry expand string.

## Syntax

```powershell
Reg_SetExpandString
	-RegRoot <String>
	-RegKey <String>
	-RegValue <String>
	-RegData <String>
```

## Description



## Examples

### Example 1
```powershell
Reg_SetExpandString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "%ProgramFiles%"
```
    

## Parameters

-**RegRoot**

The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**RegKey**

The path of the registry key.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**RegValue**

The name of the registry value.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**RegData**

The data of the registry value.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455938/cs.Reg+SetExpandString
