# Log_SectionHeader
Module: Capa.PowerShell.Module.PowerPack.Log

Creates a section header in the logfile.

## Syntax

```powershell
Log_SectionHeader
	-Name <String>
	-FrameCharacter <String>
```

## Description



## Examples

### Example 1
```powershell
Log_SectionHeader -Name "Install"
```
    
### Example 2
```powershell
Log_SectionHeader -Name "Install" -FrameCharacter "="
```
    

## Parameters

-**Name**

The name of the section.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**FrameCharacter**

The character to use for the frame, default is 'o'.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | o | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455700/cs.Log+SectionHeader
