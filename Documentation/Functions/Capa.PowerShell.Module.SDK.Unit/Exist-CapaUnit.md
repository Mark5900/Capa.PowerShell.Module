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
title: Exist-CapaUnit
---

# Exist-CapaUnit

## SYNOPSIS

Checks whether a unit exists by name/type or UUID.

## SYNTAX

### NameType

```
Exist-CapaUnit -CapaSDK <psobject> -UnitName <string> -UnitType <string> [<CommonParameters>]
```

### Uuid

```
Exist-CapaUnit -CapaSDK <psobject> -Uuid <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Checks whether a unit exists in CapaInstaller by using either the NameType
parameter set (UnitName + UnitType) or the Uuid parameter set.

## EXAMPLES

### EXAMPLE 1

Exist-CapaUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

Checks whether PC-01 exists as a computer unit.

### EXAMPLE 2

Exist-CapaUnit -CapaSDK $CapaSDK -Uuid '4f5e6d7c-8b9a-4c3d-9e0f-1a2b3c4d5e6f'

Checks whether a unit exists with the specified UUID.

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
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UnitName

Name of the unit to check.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: NameType
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UnitType

Type of unit.
Valid values are Computer and User.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: NameType
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Uuid

UUID of the unit to check.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Uuid
  Position: Named
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

### System.Boolean

{{ Fill in the Description }}

## NOTES

For more information, see:
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247388/Exist+unit
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247418/Exist+uuid


## RELATED LINKS

{{ Fill in the related links here }}

