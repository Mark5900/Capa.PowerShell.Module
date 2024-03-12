# Find-PpWinGetCmd
Module: Capa.PowerShell.Module.PowerPack.Winget

Find the path to the WinGet executable.

## Syntax

```powershell
Find-PpWinGetCmd
```

## Description

Find the path to the WinGet executable. If the WinGet executable is not found, the function will return $false.

## Examples

### Example 1
```powershell
$WingetPath = Find-PpWinGetCmd
```
    
### Example 2
```powershell
$WingetPath = Find-PpWinGetCmd -AllowInstallOfWinGet $true
```
    

## Parameters


## Notes

Custom function not from CapaSystems. 		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
