# File_CopyFile
Module: Capa.PowerShell.Module.PowerPack.File

Copy a file.

## Syntax

```powershell
File_CopyFile
	-Source <String>
	-Destination <String>
	-Overwrite <Boolean>
```

## Description



## Examples

### Example 1
```powershell
File_CopyFile -Source "C:\Temp\test.txt" -Destination "C:\Temp\test2.txt"
```
    

## Parameters

-**Source**

The source file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Destination**

The destination file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Overwrite**

Overwrite the destination file if it already exists.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455394/cs.File+CopyFile
