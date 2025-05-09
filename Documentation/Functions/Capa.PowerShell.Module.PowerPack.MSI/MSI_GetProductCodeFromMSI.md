---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.MSI-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.MSI
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: MSI_GetProductCodeFromMSI
---

# MSI_GetProductCodeFromMSI

## SYNOPSIS

Gets the product code of an MSI file.

## SYNTAX

### __AllParameterSets

```
MSI_GetProductCodeFromMSI [-MsiFile] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function retrieves the product code of the specified MSI file.

## EXAMPLES

### EXAMPLE 1

MSI_GetProductCodeFromMSI -MsiFile "C:\Temp\test.msi"

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455717/cs.MSI+GetProductCodeFromMSI


## RELATED LINKS

{{ Fill in the related links here }}

