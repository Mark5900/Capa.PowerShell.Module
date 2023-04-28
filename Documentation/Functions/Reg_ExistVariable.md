# Reg_ExistVariable
Module: Capa.PowerShell.Module.PowerPack.Reg

Exists a registry variable.

## Syntax

```powershell
Reg_ExistVariable
	-RegRoot <String>
	-RegKey <String>
	-RegVariable <String>
```

## Description



## Examples

### Example 1
```powershell
Reg_ExistVariable -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegVariable "Test"
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

-**RegVariable**

The name of the registry variable.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455887/cs.Reg+ExistVariable
