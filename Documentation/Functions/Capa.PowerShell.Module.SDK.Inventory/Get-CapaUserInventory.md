---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Inventory-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.Inventory
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: Get-CapaUserInventory
---

# Get-CapaUserInventory

## SYNOPSIS

Get software inventory for a user.

## SYNTAX

### __AllParameterSets

```
Get-CapaUserInventory [-CapaSDK] <Object> [-UserName] <Object> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Get software inventory for a user.

## EXAMPLES

### EXAMPLE 1

Get-CapaSoftwareInventoryForUser -CapaSDK $CapaSDK -UserName 'Klient'

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

### -UserName

The username of the user.

```yaml
Type: System.Object
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

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246418/Get+User+Inventory


## RELATED LINKS

{{ Fill in the related links here }}

