---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Reg-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Reg
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Reg_EnumKey
---

# Reg_EnumKey

## SYNOPSIS

Enumerates all registry keys.

## SYNTAX

### __AllParameterSets

```
Reg_EnumKey [-RegRoot] <string> [-RegPath] <string> [[-MustExist] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function enumerates all registry keys at the specified path.

## EXAMPLES

### EXAMPLE 1

Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"

### EXAMPLE 2

Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -MustExist $false

## PARAMETERS

### -MustExist

Indicates if the registry key must exist, default is $true.

```yaml
Type: System.Boolean
DefaultValue: True
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

### -RegPath

The path of the registry key.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### -RegRoot

The root of the registry key, can be HKLM, HKCU or HKU.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455853/cs.Reg+EnumKey


## RELATED LINKS

{{ Fill in the related links here }}

