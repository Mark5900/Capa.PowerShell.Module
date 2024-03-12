# Confirm-PpWingetAppInstall
Module: Capa.PowerShell.Module.PowerPack.Winget

Confirm if an app is installed.

## Syntax

```powershell
Confirm-PpWingetAppInstall
	-AppId <String>
	-WingetPath <String>
```

## Description

Confirm if an app is installed.
Returns $true if the app is installed, otherwise $false.

## Examples

### Example 1
```powershell
Confirm-PpWingetAppInstall -AppId 'Microsoft.VisualStudioCode'
```
    

## Parameters

-**AppId**

The AppId of the app to confirm.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**WingetPath**

The path to the winget executable. If not provided, the function will try to find the winget executable.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom function not from CapaSystems. 		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
