# Add-PpCMSCustomInventory
Module: Capa.PowerShell.Module.PowerPack.CMS


Add-PpCMSCustomInventory [-Category] <string> [-Entry] <string> [-Value] <string> [-ValueType] <string> [<CommonParameters>]


## Syntax

```powershell
Add-PpCMSCustomInventory
	-Category <string>
	-Entry <string>
	-Value <string>
	-ValueType <string>
```

## Description



## Examples


## Parameters

-**Category**


| Name | Value |
| ---- | ---- |
| Type: | string |
| Position: | 0 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Entry**


| Name | Value |
| ---- | ---- |
| Type: | string |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Value**


| Name | Value |
| ---- | ---- |
| Type: | string |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ValueType**


| Name | Value |
| ---- | ---- |
| Type: | string |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Please note, that this is an expensive call, seen from the Frontend/database perspective. Calling this function repeatedly from a package could result in overall slower performance. This function should be used with care.  		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726255/CMS+AddCustomInventory
