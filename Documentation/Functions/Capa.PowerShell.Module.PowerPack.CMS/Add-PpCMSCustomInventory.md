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
title: Add-PpCMSCustomInventory
---

# Add-PpCMSCustomInventory

## SYNOPSIS

Adds a custom inventory entry to the database.

## SYNTAX

### __AllParameterSets

```
Add-PpCMSCustomInventory [-Category] <string> [-Entry] <string> [-Value] <string>
 [-ValueType] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Adds a persistent CustomInventory row to the database, meaning that the data will not be flushed out the next time that the CustomInventory package is run.

## EXAMPLES

### EXAMPLE 1

$bStatus = Add-PpCMSCustomInventory -Category "MyCategory" -Entry "MyEntry" -Value "MyValue" -ValueType "String"
if ($bStatus) {
	Job_WriteLog -Text "Custom inventory added successfully."
} else {
	Job_WriteLog -Text "Failed to add custom inventory."
}

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
  Position: 0
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
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Value

Value of the variable.
If the ValueType is Time then the value should be epoch time, meaning the number of seconds since 1970-01-01 00:00:00 UTC.
You can also set the Time at "" or "0" to set the current time.

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

### -ValueType

Type of the value.
Valid values are:
- String
- Integer
- Time

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

https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726255/CMS+AddCustomInventory


## RELATED LINKS

{{ Fill in the related links here }}

