---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Reg-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Reg
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Reg_SetString
---

# Reg_SetString

## SYNOPSIS

Sets a registry string.

## SYNTAX

### __AllParameterSets

```
Reg_SetString [-RegRoot] <string> [-RegKey] <string> [-RegValue] <string> [-RegData] <string>
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Sets a registry string.

## EXAMPLES

### EXAMPLE 1

Reg_SetString -RegRoot "HKLM" -RegKey "SOFTWARE\CapaSystems" -RegValue "Test" -RegData "Test1"

## PARAMETERS

### -RegData

The data of the registry value.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -RegKey

The path of the registry key.

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

### -RegRoot

The root of the registry key, can be HKLM, HKEY_LOCAL_MACHINE, HKCU or HKU.

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

### -RegValue

The name of the registry value.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455972/cs.Reg+SetString


## RELATED LINKS

{{ Fill in the related links here }}

