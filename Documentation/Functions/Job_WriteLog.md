# Job_WriteLog
Module: Capa.PowerShell.Module.PowerPack.Job

This function will write a log entry.

## Syntax

```powershell
Job_WriteLog
	-FunctionName <String>
	-Text <String>
```

## Description



## Examples

### Example 1
```powershell
Job_WriteLog -FunctionName "Install" -Text "Installing application"
```
    
### Example 2
```powershell
Log_SectionHeader -Name "Install"
PS C:\> Job_WriteLog -Text "Installing application"
```
    

## Parameters

-**FunctionName**

Name of function to associate with log entry (default blank, Log_Sectionheader will override).
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Text**

The text to write to the log.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455683/cs.Job+WriteLog
