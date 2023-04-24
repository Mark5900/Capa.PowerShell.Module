# File_RenameDir
Module: Capa.PowerShell.Module.PowerPack.File

Rename a folder.

## Syntax

```powershell
File_RenameDir
	-Source <String>
	-Destination <String>
	-Overwrite <Boolean>
```

## Description



## Examples

### Example 1
```powershell
File_RenameDir -Source "C:\Temp\test" -Destination "C:\Temp\test2"
```
    

## Parameters

-**Source**

The folder to rename.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Destination**

The new name of the folder.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Overwrite**

Overwrite the destination folder if it already exists, default is true (equals copytree and delete source).
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | True | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455598/cs.File+RenameDir
