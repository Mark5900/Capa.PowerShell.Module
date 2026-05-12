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
title: Exist-CapaUnitLocation
---

# Exist-CapaUnitLocation

## SYNOPSIS

Checks whether a unit exists on a specific location.

## SYNTAX

### __AllParameterSets

```
Exist-CapaUnitLocation [-CapaSDK] <psobject> [-UnitName] <string> [-UnitType] <string>
 [-Location] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Checks whether the specified unit exists on the specified location by
calling the CapaSDK method ExistUnitLocation.

## EXAMPLES

### EXAMPLE 1

Exist-CapaUnitLocation -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -Location 'Default\\Devices'

Returns whether PC-01 exists on location Default\Devices.

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

### -Location

Location path to validate for the unit.

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

### -UnitName

Name of the unit to check.

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

### -UnitType

Type of unit.
Valid values are Computer and User.

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

### System.Boolean

{{ Fill in the Description }}

## NOTES

For more information, see:
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247402/Exist+unit+location


## RELATED LINKS

{{ Fill in the related links here }}

