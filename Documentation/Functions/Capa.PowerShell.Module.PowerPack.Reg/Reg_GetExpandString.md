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
title: Reg_GetExpandString
---

# Reg_GetExpandString

## SYNOPSIS

Gets a registry expand string.

## SYNTAX

### __AllParameterSets

```
Reg_GetExpandString [-RegRoot] <string> [-RegKey] <string> [-RegValue] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets a registry expand string.

## EXAMPLES

### EXAMPLE 1

Reg_GetExpandString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test"

## PARAMETERS

### -RegKey

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

The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

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

### -RegValue

The name of the registry value.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
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

## RELATED LINKS

{{ Fill in the related links here }}

