---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.MSI-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.MSI
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: MSI_IsMSIFileInstalled
---

# MSI_IsMSIFileInstalled

## SYNOPSIS

Checks if an MSI file is installed.

## SYNTAX

### __AllParameterSets

```
MSI_IsMSIFileInstalled [-MsiFile] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function checks if the specified MSI file is installed on the system.

## EXAMPLES

### EXAMPLE 1

MSI_IsMSIFileInstalled -MsiFile "C:\Temp\test.msi"

## PARAMETERS

### -MsiFile

The path to the MSI file.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455768/cs.MSI+IsMSIFileInstalled


## RELATED LINKS

{{ Fill in the related links here }}

