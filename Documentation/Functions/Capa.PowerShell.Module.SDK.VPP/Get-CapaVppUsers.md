---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.VPP-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.VPP
ms.date: 05/12/2026
PlatyPS schema version: 2024-05-01
title: Get-CapaVppUsers
---

# Get-CapaVppUsers

## SYNOPSIS

Gets a list of all VPP users.

## SYNTAX

### __AllParameterSets

```
Get-CapaVppUsers [-CapaSDK] <psobject> [[-VppProgramID] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets a list of all VPP users, if VppProgramID is specified, only VPP users for the specified program will be returned.

## EXAMPLES

### EXAMPLE 1

Get-CapaVppUsers -CapaSDK $CapaSDK

### EXAMPLE 2

Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 1

## PARAMETERS

### -CapaSDK

The CapaSDK object.

```yaml
Type: System.Management.Automation.PSObject
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

### -VppProgramID

A description of the VppProgramID parameter.

```yaml
Type: System.Nullable`1[System.Int32]
DefaultValue: ''
SupportsWildcards: false
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

### System.Management.Automation.PSObject

{{ Fill in the Description }}

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247808/Get+vpp+users
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247818/Get+vpp+users+all


## RELATED LINKS

{{ Fill in the related links here }}

