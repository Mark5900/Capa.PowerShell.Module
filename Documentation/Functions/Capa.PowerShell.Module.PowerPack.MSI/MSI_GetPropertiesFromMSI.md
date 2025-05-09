---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.MSI-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.MSI
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: MSI_GetPropertiesFromMSI
---

# MSI_GetPropertiesFromMSI

## SYNOPSIS

Gets the values of properties from an MSI file.

## SYNTAX

### __AllParameterSets

```
MSI_GetPropertiesFromMSI [-MsiFile] <string> [[-Property] <array>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function retrieves the values of specified properties from an MSI file.

## EXAMPLES

### EXAMPLE 1

MSI_GetPropertiesFromMSI -MsiFile "C:\Temp\test.msi" -Property @("ProductVersion","UpgradeCode","ProductCode","ProductName","Manufacture")

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

### -Property

Array of properties to retrieve.

```yaml
Type: System.Array
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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455751/cs.MSI+GetPropertiesFromMSI


## RELATED LINKS

{{ Fill in the related links here }}

