# Install-PpWingetApp
Module: Capa.PowerShell.Module.PowerPack.Winget

Install an application using winget

## Syntax

```powershell
Install-PpWingetApp
	-AppId <String>
	-Locale <String>
	-AllowInstallOfWinGet <Boolean>
```

## Description

Install an application using winget

## Examples

### Example 1
```powershell
Install-PpWingetApp -Id 'Mozilla.Firefox'
```
    
### Example 2
```powershell
Install-PpWingetApp -Id 'Mozilla.Firefox' -Locale 'da-DK'
```
    
### Example 3
```powershell
Install-PpWingetApp -Id 'Mozilla.Firefox' -AllowInstallOfWinGet $true
```
    

## Parameters

-**AppId**


| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Locale**

The locale to use for the installation, for example 'da-DK'
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowInstallOfWinGet**

Allow the installation of winget if it is not installed. Or update winget if it is installed.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom function not from CapaSystems. 		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
