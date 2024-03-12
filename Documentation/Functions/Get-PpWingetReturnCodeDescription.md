# Get-PpWingetReturnCodeDescription
Module: Capa.PowerShell.Module.PowerPack.Winget

Get the error message for a WinGet error code.

## Syntax

```powershell
Get-PpWingetReturnCodeDescription
	-Decimal <Int32>
```

## Description

Get the error message for a WinGet error code.

## Examples

### Example 1
```powershell
Get-PpWingetReturnCodeDescription -Decimal -1978335231
```
    

## Parameters

-**Decimal**

The error code in decimal.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 1 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

Custom function not from CapaSystems. 		Source: https://github.com/microsoft/winget-cli/blob/master/doc/windows/package-manager/winget/returnCodes.md
