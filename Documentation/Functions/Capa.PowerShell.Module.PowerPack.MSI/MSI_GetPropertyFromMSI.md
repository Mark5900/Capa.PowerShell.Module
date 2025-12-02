---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.MSI-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.MSI
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: MSI_GetPropertyFromMSI
---

# MSI_GetPropertyFromMSI

## SYNOPSIS

Gets the value of a property from an MSI file.

## SYNTAX

### __AllParameterSets

```
MSI_GetPropertyFromMSI [-MsiFile] <string> [-Property] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function retrieves the value of a specified property from an MSI file.

## EXAMPLES

### EXAMPLE 1

MSI_GetPropertyFromMSI -MsiFile "C:\Temp\test.msi" -Property "ProductVersion"

## PARAMETERS

### -MsiFile

The path to the MSI file.

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

### -Property

The property to get the value from.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455734/cs.MSI+GetPropertyFromMSI


## RELATED LINKS

{{ Fill in the related links here }}

