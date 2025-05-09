---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Inventory-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.Inventory
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Get-CapaCustomInventoryForUnit
---

# Get-CapaCustomInventoryForUnit

## SYNOPSIS

Get the custom inventory for a unit.

## SYNTAX

### NameType

```
Get-CapaCustomInventoryForUnit -CapaSDK <Object> -UnitName <string> -UnitType <string>
 [<CommonParameters>]
```

### Uuid

```
Get-CapaCustomInventoryForUnit -CapaSDK <Object> -Uuid <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Get the custom inventory for a unit, with the option to get the inventory by name and type or by UUID.

## EXAMPLES

### EXAMPLE 1

Get-CapaCustomInventoryForUnit -Uuid 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B'

### EXAMPLE 2

Get-CapaCustomInventoryForUnit -UnitName 'CAPA-TEST-01' -UnitType 'Computer'

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

The name of the unit.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

The type of the unit.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

The UUID of the unit.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246358/Get+custom+inventory+for+unit


## RELATED LINKS

{{ Fill in the related links here }}

