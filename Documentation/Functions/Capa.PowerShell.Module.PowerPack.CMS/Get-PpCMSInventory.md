---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.CMS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.CMS
ms.date: 10/16/2026
PlatyPS schema version: 2024-05-01
title: Get-PpCMSInventory
---

# Get-PpCMSInventory

## SYNOPSIS

Gets inventory values from the database.

## SYNTAX

### __AllParameterSets

```
Get-PpCMSInventory [-Table] <string> [-Category] <string> [-Entry] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets inventory values from the database, from either the Hardware, Custom, or Logon inventory tables.

## EXAMPLES

### EXAMPLE 1

$value = Get-PpCMSInventory -Table 'Hardware Inventory' -Category 'System' -Entry 'Name'
Job_WriteLog -Text "Name: $value"

## PARAMETERS

### -Category

Category name

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

### -Entry

Variable name

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

### -Table

This is the table toward which the request is made, and it can be either 'Hardware Inventory', 'Logon Inventory', or 'Custom Inventory'.

```yaml
Type: System.String
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Please note, that this is an expensive call, seen from the Frontend/database perspective.
Calling this function repeatedly from a package could result in overall slower performance.
This function should be used with care.


## RELATED LINKS

{{ Fill in the related links here }}

