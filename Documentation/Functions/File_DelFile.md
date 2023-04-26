# File_DelFile
Module: Capa.PowerShell.Module.PowerPack.File

Delete a file.

## Syntax

```powershell
File_DelFile
	-FilePath <String>
	-Recursive <Boolean>
```

## Description



## Examples

### Example 1
```powershell
File_DelFile -FilePath "C:\Temp\test.txt"
```
    

## Parameters

-**FilePath**

The file to delete.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Recursive**

Delete files from sub directories, relative to FilePath. Default is false.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 2 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455479/cs.File+DelFile
