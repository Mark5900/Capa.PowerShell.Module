# MSI_GetPropertiesFromMSI
Module: Capa.PowerShell.Module.PowerPack.MSI

Gets the values of properties from an MSI file.

## Syntax

```powershell
MSI_GetPropertiesFromMSI
	-MsiFile <String>
	-Property <Array>
```

## Description



## Examples

### Example 1
```powershell
MSI_GetPropertiesFromMSI -MsiFile "C:\Temp\test.msi" -Property @("ProductVersion","UpgradeCode","ProductCode","ProductName","Manufacture")
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

Array of properties to retrieve.
| Name | Value |
| ---- | ---- |
| Type: | Array |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455751/cs.MSI+GetPropertiesFromMSI
