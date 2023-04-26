# Reg_EnumKey
Module: Capa.PowerShell.Module.PowerPack.Reg

Enumerates all registry keys.

## Syntax

```powershell
Reg_EnumKey
	-RegRoot <String>
	-RegPath <String>
	-MustExist <Boolean>
```

## Description



## Examples

### Example 1
```powershell
Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"
```
    
### Example 2
```powershell
Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -MustExist $false
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

-**MustExist**

Indicates if the registry key must exist, default is $true.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455853/cs.Reg+EnumKey
