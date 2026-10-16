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
title: Remove-PpCMSComputerFromDepartmentGroup
---

# Remove-PpCMSComputerFromDepartmentGroup

## SYNOPSIS

Removes a specified computer unit from a department group.

## SYNTAX

### __AllParameterSets

```
Remove-PpCMSComputerFromDepartmentGroup [-Group] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Removes a specified computer unit from a department group.

## EXAMPLES

### EXAMPLE 1

$bStatus = Remove-PpCMSComputerFromDepartmentGroup -Group "MyDepartmentGroup"
if ($bStatus) {
	Job_WriteLog -Text "Computer unit removed from department group."
} else {
	Job_WriteLog -Text "Failed to remove computer unit from department group."
}

## PARAMETERS

### -Group

The name of the department group from which the computer unit should be removed.

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

