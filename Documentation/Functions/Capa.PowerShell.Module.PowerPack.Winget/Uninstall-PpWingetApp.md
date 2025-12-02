---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Winget-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Winget
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: Uninstall-PpWingetApp
---

# Uninstall-PpWingetApp

## SYNOPSIS

Uninstalls an application using winget.

## SYNTAX

### __AllParameterSets

```
Uninstall-PpWingetApp [-AppId] <string> [[-AllowInstallOfWinGet] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Uninstalls an application using winget.

## EXAMPLES

### EXAMPLE 1

Uninstall-PpWingetApp -AppId 'Mozilla.Firefox'

### EXAMPLE 2

Uninstall-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true

## PARAMETERS

### -AllowInstallOfWinGet

Allow the installation of winget if it is not installed.
Or update winget if it is installed.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
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

### -AppId

The id of the application to uninstall.
You can find all the available applications on https://winget.run

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
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


## RELATED LINKS

{{ Fill in the related links here }}

