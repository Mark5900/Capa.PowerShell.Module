# Get-PpCMSDeploymentTemplateVariable
Module: Capa.PowerShell.Module.PowerPack.CMS


Get-PpCMSDeploymentTemplateVariable [[-Section] <string>] [-Variable] <string> [[-MustExist] <bool>] [<CommonParameters>]


## Syntax

```powershell
Get-PpCMSDeploymentTemplateVariable
	-Section <string>
	-Variable <string>
	-MustExist <bool>
```

## Description



## Examples


## Parameters

-**MustExist**


| Name | Value |
| ---- | ---- |
| Type: | bool |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Section**


| Name | Value |
| ---- | ---- |
| Type: | string |
| Position: | 0 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Variable**


| Name | Value |
| ---- | ---- |
| Type: | string |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Example configutation: 		{ 			"operatingSystem": { 				"ImageId": 13, 				"diskConfigId": 1, 				"localAdmin": "true", 				"password": "15aarest" 			}, 			"domain": { 				"joinDomain": "CAPADEMO.LOCAL", 				"domainName": "CAPADEMO.LOCAL", 				"domainUserName": "ciinst", 				"domainUserPassword": "dftgyhuj", 				"computerObjectOU": "OU=Computers,OU=Lazise,OU=Dev2,DC=CAPADEMO,DC=local"}, 			"title": "Default", 			"customValues": [{ 				"key": "a", 				"value": "1" 			}] 		}
