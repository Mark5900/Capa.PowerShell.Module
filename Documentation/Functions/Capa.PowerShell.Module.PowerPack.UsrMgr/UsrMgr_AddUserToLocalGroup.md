---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.UsrMgr-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.UsrMgr
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: UsrMgr_AddUserToLocalGroup
---

# UsrMgr_AddUserToLocalGroup

## SYNOPSIS

Adds a user to a local group.

## SYNTAX

### __AllParameterSets

```
UsrMgr_AddUserToLocalGroup [-UserName] <string> [-GroupName] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function adds a user to a local group on the system.

## EXAMPLES

### EXAMPLE 1

UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "Administrators"

### EXAMPLE 2

UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "S-1-5-32-544"

## PARAMETERS

### -GroupName

The name of the group to add the user to.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- SID
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

### -UserName

The name of the user to add to the group.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456159/cs.UsrMgr+AddUserToLocalGroup


## RELATED LINKS

{{ Fill in the related links here }}

