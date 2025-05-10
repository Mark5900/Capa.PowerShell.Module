---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.UsrMgr-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.UsrMgr
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: UsrMgr_ExistLocalUserAccount
---

# UsrMgr_ExistLocalUserAccount

## SYNOPSIS

Check if a local user account exists.

## SYNTAX

### __AllParameterSets

```
UsrMgr_ExistLocalUserAccount [-UserName] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function checks if a local user account exists on the specified domain or local machine.

## EXAMPLES

### EXAMPLE 1

UsrMgr_ExistLocalUserAccount -UserName "JohnDoe"

## PARAMETERS

### -UserName

The name of the user to check for.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456227/cs.UsrMgr+ExistLocalUserAccount


## RELATED LINKS

{{ Fill in the related links here }}

