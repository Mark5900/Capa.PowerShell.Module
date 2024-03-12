# Update-PpWingetApp
Module: Capa.PowerShell.Module.PowerPack.Winget

Updates an application using winget.

## Syntax

```powershell
Update-PpWingetApp
	-AppId <String>
	-Locale <String>
	-UninstallPrevious <Boolean>
	-AllowInstallOfWinGet <Boolean>
```

## Description

Updates an application using winget.

## Examples

### Example 1
```powershell
Update-PpWingetApp -AppId 'Mozilla.Firefox'
```
    
### Example 2
```powershell
Update-PpWingetApp -AppId 'Mozilla.Firefox' -Locale 'da-DK'
```
    
### Example 3
```powershell
Update-PpWingetApp -AppId 'Mozilla.Firefox' -UninstallPrevious $true
```
    
### Example 4
```powershell
Update-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true
```
    

## Parameters

-**AppId**

The id of the application to update.
You can find all the available applications on https://winget.run
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

-**UninstallPrevious**

Uninstall the previous version of the package during upgrade.Behavior will depend on the individual package. Some installers are designed to install new versions side-by-side. Some installers include a manifest that specifies “uninstallPrevious” so earlier versions are uninstalled without needing to use this command flag. In this case, using the winget upgrade --uninstall-previous command will tell WinGet to uninstall the previous version regardless of what is in the package manifest. If the package manifest does not include “uninstallPrevious” and the --uninstall-previous flag is not used, then the default behavior for the installer will apply.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 3 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowInstallOfWinGet**

Allow the installation of winget if it is not installed. Or update winget if it is installed.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 4 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes


