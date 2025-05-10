---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Winget-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Winget
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Install-PpWingetApp
---

# Install-PpWingetApp

## SYNOPSIS

Install an application using winget

## SYNTAX

### __AllParameterSets

```
Install-PpWingetApp [-AppId] <string> [[-Locale] <string>] [[-AllowInstallOfWinGet] <bool>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Install an application using winget

## EXAMPLES

### EXAMPLE 1

Install-PpWingetApp -Id 'Mozilla.Firefox'

### EXAMPLE 2

Install-PpWingetApp -Id 'Mozilla.Firefox' -Locale 'da-DK'

### EXAMPLE 3

Install-PpWingetApp -Id 'Mozilla.Firefox' -AllowInstallOfWinGet $true

## PARAMETERS

### -AllowInstallOfWinGet

Allow the installation of winget if it is not installed.
Or update winget if it is installed.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AppId

{{ Fill AppId Description }}

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

### -Locale

The locale to use for the installation, for example 'da-DK'

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

