---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.WSUS-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.WSUS
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Get-CapaWSUSGroupUnits
---

# Get-CapaWSUSGroupUnits

## SYNOPSIS

Gets a list of units linked to a WSUS group.

## SYNTAX

### __AllParameterSets

```
Get-CapaWSUSGroupUnits [-CapaSDK] <Object> [-WSUSGroupName] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets a list of units linked to a WSUS group.

## EXAMPLES

### EXAMPLE 1

Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName "WSUS Group"

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

### -WSUSGroupName

The name of the WSUS group.

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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247622/Get+WSUS+Group+units


## RELATED LINKS

{{ Fill in the related links here }}

