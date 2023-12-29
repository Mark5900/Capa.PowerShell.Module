# Exit-PpPackageNotCompliant
Module: Capa.PowerShell.Module.PowerPack.Exit

Set error code that the package is not compliant.

## Syntax

```powershell
Exit-PpPackageNotCompliant
	-ExitMessage <String>
```

## Description

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## Examples

### Example 1
```powershell
Exit-PpPackageNotCompliant
```
    
### Example 2
```powershell
Exit-PpPackageNotCompliant -ExitMessage 'Test where I set ExitMessage'
```
    

## Parameters

-**ExitMessage**


| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom command.
