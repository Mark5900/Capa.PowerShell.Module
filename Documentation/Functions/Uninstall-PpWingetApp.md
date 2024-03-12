# Uninstall-PpWingetApp
Module: Capa.PowerShell.Module.PowerPack.Winget

Uninstalls an application using winget.

## Syntax

```powershell
Uninstall-PpWingetApp
	-AppId <String>
	-AllowInstallOfWinGet <Boolean>
```

## Description

Uninstalls an application using winget.

## Examples

### Example 1
```powershell
Uninstall-PpWingetApp -AppId 'Mozilla.Firefox'
```
    
### Example 2
```powershell
Uninstall-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true
```
    

## Parameters

-**AppId**

The id of the application to uninstall.
You can find all the available applications on https://winget.run
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowInstallOfWinGet**

Allow the installation of winget if it is not installed. Or update winget if it is installed.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 2 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom function not from CapaSystems.
