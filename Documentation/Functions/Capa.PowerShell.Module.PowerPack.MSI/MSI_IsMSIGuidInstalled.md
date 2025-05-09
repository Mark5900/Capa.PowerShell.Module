---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.MSI-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.MSI
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: MSI_IsMSIGuidInstalled
---

# MSI_IsMSIGuidInstalled

## SYNOPSIS

Checks if an GUID is installed.

## SYNTAX

### __AllParameterSets

```
MSI_IsMSIGuidInstalled [-MsiGuid] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function checks if the specified GUID is installed on the system.

## EXAMPLES

### EXAMPLE 1

MSI_IsMSIGuidInstalled -MsiGuid "{AC76BA86-1033-FF00-7760-BC15014EA700}"

## PARAMETERS

### -MsiGuid

TMSI Productcode to check installation status of.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455785/cs.MSI+IsMSIGuidInstalled


## RELATED LINKS

{{ Fill in the related links here }}

