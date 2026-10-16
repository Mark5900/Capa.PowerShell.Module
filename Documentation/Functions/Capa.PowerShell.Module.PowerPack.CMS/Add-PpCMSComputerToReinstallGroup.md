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
title: Add-PpCMSComputerToReinstallGroup
---

# Add-PpCMSComputerToReinstallGroup

## SYNOPSIS

Add a computer to a Reinstall Group.

## SYNTAX

### __AllParameterSets

```
Add-PpCMSComputerToReinstallGroup [-Group] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Add a computer to a Reinstall Group.

## EXAMPLES

### EXAMPLE 1

$bStatus = Add-PpCMSComputerToReinstallGroup -Group "MyGroup"
if ($bStatus) {
	Job_WriteLog -Text "Computer added to Reinstall Group."
} else {
	Job_WriteLog -Text "Failed to add computer to Reinstall Group."
}

## PARAMETERS

### -Group

The name of the Reinstall Group.

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

https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726217/CMS+AddComputerToReinstallGroup


## RELATED LINKS

{{ Fill in the related links here }}

