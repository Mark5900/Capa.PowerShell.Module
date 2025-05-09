---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Winget-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.Winget
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Get-PpWingetReturnCodeDescription
---

# Get-PpWingetReturnCodeDescription

## SYNOPSIS

Get the error message for a WinGet error code.

## SYNTAX

### __AllParameterSets

```
Get-PpWingetReturnCodeDescription [-Decimal] <int> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Get the error message for a WinGet error code.

## EXAMPLES

### EXAMPLE 1

Get-PpWingetReturnCodeDescription -Decimal -1978335231

## PARAMETERS

### -Decimal

The error code in decimal.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Custom function not from CapaSystems.
Source: https://github.com/microsoft/winget-cli/blob/master/doc/windows/package-manager/winget/returnCodes.md


## RELATED LINKS

{{ Fill in the related links here }}

