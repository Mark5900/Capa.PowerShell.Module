---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.UsrMgr-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.UsrMgr
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: UsrMgr_EnumMembersOfLocalGroup
---

# UsrMgr_EnumMembersOfLocalGroup

## SYNOPSIS

Get group members of a local group.

## SYNTAX

### __AllParameterSets

```
UsrMgr_EnumMembersOfLocalGroup [-GroupName] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function retrieves the members of a local group on the system.

## EXAMPLES

### EXAMPLE 1

UsrMgr_EnumMembersOfLocalGroup -GroupName "Administrators"

## PARAMETERS

### -GroupName

The name of the group to get the members of.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456176/cs.UsrMgr+EnumMembersOfLocalGroup


## RELATED LINKS

{{ Fill in the related links here }}

