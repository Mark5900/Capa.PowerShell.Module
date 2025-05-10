---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.OSDeployment-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.OSDeployment
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Get-CapaOSDiskConfigration
---

# Get-CapaOSDiskConfigration

## SYNOPSIS

Gets a list of OS Disk Configurations.

## SYNTAX

### __AllParameterSets

```
Get-CapaOSDiskConfigration [-CapaSDK] <Object> [-OSPointID] <int> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets a list of OS Disk Configurations.

## EXAMPLES

### EXAMPLE 1

Get-CapaOSDiskConfigration -CapaSDK $CapaSDK -OSPointID 1

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

### -OSPointID

The ID of the OS Point.

```yaml
Type: System.Int32
DefaultValue: 0
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246664/Get+OS+disk+configurations


## RELATED LINKS

{{ Fill in the related links here }}

