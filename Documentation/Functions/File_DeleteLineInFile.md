# File_DeleteLineInFile
Module: Capa.PowerShell.Module.PowerPack.File

Delete a line in a file.

## Syntax

```powershell
File_DeleteLineInFile
	-File <String>
	-Text <String>
	-OnlyFirstMatch <Boolean>
	-IgnoreCase <Boolean>
```

## Description



## Examples

### Example 1
```powershell
File_DeleteLineInFile -File "C:\Temp\test.txt" -Text "Hello World"
```
    

## Parameters

-**File**

The file to delete the line from.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Text**

The text to delete from the file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**OnlyFirstMatch**

Delete only the first match, default is false.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**IgnoreCase**

Ignore case, default is false.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 4 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455462/cs.File+DeleteLineInFile
