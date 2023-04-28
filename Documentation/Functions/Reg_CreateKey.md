# Reg_CreateKey
Module: Capa.PowerShell.Module.PowerPack.Reg

Creates a registry key.

## Syntax

```powershell
Reg_CreateKey
	-RegRoot <String>
	-RegPath <String>
```

## Description



## Examples

### Example 1
```powershell
Reg_CreateKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"
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


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455819/cs.Reg+CreateKey
