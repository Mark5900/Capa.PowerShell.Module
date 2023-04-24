# MSI_GetPropertyFromMSI
Module: Capa.PowerShell.Module.PowerPack.MSI

Gets the value of a property from an MSI file.

## Syntax

```powershell
MSI_GetPropertyFromMSI
	-MsiFile <String>
	-Property <String>
```

## Description



## Examples

### Example 1
```powershell
MSI_GetPropertyFromMSI -MsiFile "C:\Temp\test.msi" -Property "ProductVersion"
```
    

## Parameters

-**MsiFile**

The path to the MSI file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Property**

The property to get the value from.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455734/cs.MSI+GetPropertyFromMSI
