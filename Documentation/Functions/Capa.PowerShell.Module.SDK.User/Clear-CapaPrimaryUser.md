---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.User-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.User
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Clear-CapaPrimaryUser
---

# Clear-CapaPrimaryUser

## SYNOPSIS

Clear the primary user on a unit.

## SYNTAX

### __AllParameterSets

```
Clear-CapaPrimaryUser [-CapaSDK] <Object> [-Uuid] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Clear the primary user on a unit.

## EXAMPLES

### EXAMPLE 1

Clear-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4'

## PARAMETERS

### -CapaSDK

The CapaSDK object.

```yaml
Type: System.Object
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

### -Uuid

The UUID of the unit or device.

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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247356/Clear+Primary+User


## RELATED LINKS

{{ Fill in the related links here }}

