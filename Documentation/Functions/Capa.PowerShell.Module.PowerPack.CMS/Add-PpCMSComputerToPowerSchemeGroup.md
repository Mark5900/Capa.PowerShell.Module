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
title: Add-PpCMSComputerToPowerSchemeGroup
---

# Add-PpCMSComputerToPowerSchemeGroup

## SYNOPSIS

Adds a specified computer unit to a power scheme group.

## SYNTAX

### __AllParameterSets

```
Add-PpCMSComputerToPowerSchemeGroup [-Group] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Adds a specified computer unit to a power scheme group.

## EXAMPLES

### EXAMPLE 1

$bStatus = Add-PpCMSComputerToPowerSchemeGroup -Group "MyPowerSchemeGroup"
if ($bStatus) {
	Job_WriteLog -Text "Computer unit added to power scheme group."
} else {
	Job_WriteLog -Text "Failed to add computer unit to power scheme group."
}

## PARAMETERS

### -Group

The name of the power scheme group to which the computer unit should be added.

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

https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726200/CMS+AddComputerToPowerSchemeGroup


## RELATED LINKS

{{ Fill in the related links here }}

