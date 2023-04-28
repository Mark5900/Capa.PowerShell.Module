# Reg_DeleteVariable
Module: Capa.PowerShell.Module.PowerPack.Reg

Deletes a registry value.

## Syntax

```powershell
Reg_DeleteVariable
	-RegRoot <String>
	-RegPath <String>
	-RegValue <String>
```

## Description



## Examples

### Example 1
```powershell
Reg_DeleteVariable -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -RegValue "Test"
```
    

## Parameters

-**RegRoot**

The root of the registry key, can be HKLM, HKCU or HKU.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**RegPath**

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


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455802/cs.Reg+DeleteVariable
