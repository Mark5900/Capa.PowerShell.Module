---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Container-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.Container
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Get-CapaSchedule
---

# Get-CapaSchedule

## SYNOPSIS

Returns a schedule object by id.

## SYNTAX

### __AllParameterSets

```
Get-CapaSchedule [-CapaSDK] <Object> [-Id] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Will return something like this: 5|06-01-2011 12:00:00||0|00:00:00|1.00:00:00|Periodical|RecurEvery[1] weeks on [Monday-Tuesday-Wednesday-Thursday-Friday-Saturday-Sunday]|Weekly||True||842b2894-cdab-4a2c-905c-17ee052179db

## EXAMPLES

### EXAMPLE 1

Get-CapaSchedule -CapaSDK $CapaSDK -Id '5'

## PARAMETERS

### -CapaSDK

The CapaSDK object.

```yaml
Type: System.Object
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

### -Id

Id of the requested unit.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580716/Get+schedule


## RELATED LINKS

{{ Fill in the related links here }}

