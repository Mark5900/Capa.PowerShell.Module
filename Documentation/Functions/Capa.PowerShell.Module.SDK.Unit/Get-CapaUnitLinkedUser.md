---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Unit-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.Unit
ms.date: 05/12/2026
PlatyPS schema version: 2024-05-01
title: Get-CapaUnitLinkedUser
---

# Get-CapaUnitLinkedUser

## SYNOPSIS

Gets linked user entries for a computer unit.

## SYNTAX

### __AllParameterSets

```
Get-CapaUnitLinkedUser [-CapaSDK] <psobject> [-ComputerName] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets users linked to the specified computer by calling the CapaSDK method
GetUnitLinkedUser and returns parsed user objects.

## EXAMPLES

### EXAMPLE 1

Get-CapaUnitLinkedUser -CapaSDK $CapaSDK -ComputerName 'PC-01'

Returns linked user entries for PC-01.

## PARAMETERS

### -CapaSDK

The initialized CapaSDK instance from Initialize-CapaSDK.

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

### -ComputerName

Name of the computer unit to query linked users for.

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

### System.Management.Automation.PSObject

{{ Fill in the Description }}

## NOTES

For more information, see:
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247510/Get+unit+linked+user


## RELATED LINKS

{{ Fill in the related links here }}

