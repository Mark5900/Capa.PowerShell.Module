---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.SystemSdk-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.SystemSdk
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: Count-CapaConscomActions
---

# Count-CapaConscomActions

## SYNOPSIS

Counts the number of conscom actions.

## SYNTAX

### __AllParameterSets

```
Count-CapaConscomActions [-CapaSDK] <Object> [-ManagementServerID] <int> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Counts the number of conscom actions.

## EXAMPLES

### EXAMPLE 1

Count-CapaConscomActions -CapaSDK $CapaSDK -ManagementServerID 1

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

### -ManagementServerID

The management server ID to check for.
If omitted, conscom actions for all servers are counted.

```yaml
Type: System.Int32
DefaultValue: 0
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247078/Count+conscom+actions


## RELATED LINKS

{{ Fill in the related links here }}

