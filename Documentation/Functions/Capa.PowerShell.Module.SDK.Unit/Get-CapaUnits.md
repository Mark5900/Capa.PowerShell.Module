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
title: Get-CapaUnits
---

# Get-CapaUnits

## SYNOPSIS

Gets units from CapaInstaller.

## SYNTAX

### __AllParameterSets

```
Get-CapaUnits [-CapaSDK] <psobject> [[-Type] <string>] [[-BusinessUnit] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets units by type, or from a specific business unit, by calling CapaSDK.
If BusinessUnit is provided, data is retrieved with GetUnitsOnBusinessUnit.

## EXAMPLES

### EXAMPLE 1

Get-CapaUnits -CapaSDK $CapaSDK -Type Computer

Returns computer units.

### EXAMPLE 2

Get-CapaUnits -CapaSDK $CapaSDK -BusinessUnit 'Default'

Returns units on business unit Default.

## PARAMETERS

### -BusinessUnit

Optional business unit name.
When provided, units are fetched from
the specified business unit.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

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

### -Type

Optional unit type filter.
Valid values are Computer and User.

```yaml
Type: System.String
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

For more information, see:
https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247572/Get+units


## RELATED LINKS

{{ Fill in the related links here }}

