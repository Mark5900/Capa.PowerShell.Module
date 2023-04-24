# Job_Start
Module: Capa.PowerShell.Module.PowerPack.Job

This function will initialize the Powershell Scripting Library and set logpath and other variables.

## Syntax

```powershell
Job_Start
	-JobType <String>
	-PackageName <String>
	-PackageVersion <String>
	-LogPath <String>
	-Action <String>
```

## Description



## Examples

### Example 1
```powershell
Job_Start -JobType "WS" -PackageName $Appname -PackageVersion $AppRelease -LogPath $LogFile -Action "Install"
```
    

## Parameters

-**JobType**

The type of the job.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageName**

The name of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**LogPath**

The path to the log file.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Action**

The action to perform.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455360/cs.Job+Start
