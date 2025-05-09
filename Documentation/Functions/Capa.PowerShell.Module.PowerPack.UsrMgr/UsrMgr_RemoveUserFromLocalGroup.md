---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.UsrMgr-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.UsrMgr
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: UsrMgr_RemoveUserFromLocalGroup
---

# UsrMgr_RemoveUserFromLocalGroup

## SYNOPSIS

Remove a user from a local group.

## SYNTAX

### __AllParameterSets

```
UsrMgr_RemoveUserFromLocalGroup [[-Domain] <Object>] [-UserName] <string> [-GroupName] <string>
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Removes a user from a local group on the specified domain or local machine.

## EXAMPLES

### EXAMPLE 1

UsrMgr_RemoveUserFromLocalGroup -UserName "JohnDoe" -GroupName "Administrators"

## PARAMETERS

### -Domain

{{ Fill Domain Description }}

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -GroupName

The name of the group to remove the user from.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### -UserName

The name of the user to remove from the group.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456244/cs.UsrMgr+RemoveUserFromLocalGroup


## RELATED LINKS

{{ Fill in the related links here }}

