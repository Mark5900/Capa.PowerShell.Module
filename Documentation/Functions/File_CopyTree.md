# File_CopyTree
Module: Capa.PowerShell.Module.PowerPack.File

Copy a folder.

## Syntax

```powershell
File_CopyTree
	-Source <String>
	-Destination <String>
	-CopySubDirs <Boolean>
	-Overwrite <Boolean>
```

## Description



## Examples

### Example 1
```powershell
File_CopyTree -Source "C:\Temp\test" -Destination "C:\Temp\test2"
```
    

## Parameters

-**Source**

The source folder.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Destination**

The destination folder and creates destination folder if it does not exist.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**CopySubDirs**

Copy sub directories, default is true.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Overwrite**

Overwrite the destination files if they already exists, default is true.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 4 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455411/cs.File+CopyTree
