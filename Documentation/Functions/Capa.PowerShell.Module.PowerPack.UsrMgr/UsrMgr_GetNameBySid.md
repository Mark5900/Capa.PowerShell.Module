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
title: UsrMgr_GetNameBySid
---

# UsrMgr_GetNameBySid

## SYNOPSIS

Gets the name of a user by its SID.

## SYNTAX

### __AllParameterSets

```
UsrMgr_GetNameBySid [-SID] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Gets the name of a user by its SID.

## EXAMPLES

### EXAMPLE 1

UsrMgr_GetNameBySid -SID "S-1-5-21-3623811015-3361044348-30300820-1013"

## PARAMETERS

### -SID

The SID of the user.

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

