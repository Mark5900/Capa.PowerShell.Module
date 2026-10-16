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
title: Add-PpCMSUnitToBusinessUnit
---

# Add-PpCMSUnitToBusinessUnit

## SYNOPSIS

Adds the unit to the specified business unit

## SYNTAX

### __AllParameterSets

```
Add-PpCMSUnitToBusinessUnit [-BusinessUnitName] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Adds the unit on which the script is executed to the specified Business Unit.
UserJobs add user and ComputerJobs add the computer.

## EXAMPLES

### EXAMPLE 1

$bStatus = Add-PpCMSUnitToBusinessUnit -BusinessUnitName "MyBusinessUnit"
if ($bStatus) {
	Job_WriteLog -Text "Unit added to business unit."
} else {
	Job_WriteLog -Text "Failed to add unit to business unit."
}

## PARAMETERS

### -BusinessUnitName

The name of the business unit to add the unit to

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

## RELATED LINKS

{{ Fill in the related links here }}

