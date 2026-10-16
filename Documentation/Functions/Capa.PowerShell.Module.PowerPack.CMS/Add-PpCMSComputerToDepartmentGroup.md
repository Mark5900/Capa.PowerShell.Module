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
title: Add-PpCMSComputerToDepartmentGroup
---

# Add-PpCMSComputerToDepartmentGroup

## SYNOPSIS

Adds a specified computer unit to a department group.

## SYNTAX

### __AllParameterSets

```
Add-PpCMSComputerToDepartmentGroup [-Group] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Adds a specified computer unit to a department group.

## EXAMPLES

### EXAMPLE 1

$bStatus = Add-PpCMSComputerToDepartmentGroup -Group "MyDepartmentGroup"
if ($bStatus) {
	Job_WriteLog -Text "Computer unit added to department group."
} else {
	Job_WriteLog -Text "Failed to add computer unit to department group."
}

## PARAMETERS

### -Group

The name of the department group to which the computer unit should be added.

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

https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726181/CMS+AddComputerToDepartmentGroup


## RELATED LINKS

{{ Fill in the related links here }}

