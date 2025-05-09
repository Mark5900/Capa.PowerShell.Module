---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Winget-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.Winget
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Confirm-PpWingetAppInstall
---

# Confirm-PpWingetAppInstall

## SYNOPSIS

Confirm if an app is installed.

## SYNTAX

### __AllParameterSets

```
Confirm-PpWingetAppInstall [-AppId] <string> [[-WingetPath] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Confirm if an app is installed.
Returns $true if the app is installed, otherwise $false.

## EXAMPLES

### EXAMPLE 1

Confirm-PpWingetAppInstall -AppId 'Microsoft.VisualStudioCode'

## PARAMETERS

### -AppId

The AppId of the app to confirm.

```yaml
Type: System.String
DefaultValue: ''
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

### -WingetPath

The path to the winget executable.
If not provided, the function will try to find the winget executable.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
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
Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1


## RELATED LINKS

{{ Fill in the related links here }}

