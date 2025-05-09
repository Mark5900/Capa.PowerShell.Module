---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.UsrMgr-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.UsrMgr
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: UsrMgr_CreateLocalUser
---

# UsrMgr_CreateLocalUser

## SYNOPSIS

Create a local user account.

## SYNTAX

### __AllParameterSets

```
UsrMgr_CreateLocalUser [-UserName] <string> [-FullName] <string> [-Password] <string>
 [[-Description] <string>] [[-PasswordNeverExpire] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function creates a local user account on the system.

## EXAMPLES

### EXAMPLE 1

UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd"

### EXAMPLE 2

UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd" -Description "This is a test user."

### EXAMPLE 3

UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd" -PasswordNeverExpire $false

## PARAMETERS

### -Description

The description of the user to create.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FullName

The full name of the user to create.

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

### -Password

The password of the user to create.

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

### -PasswordNeverExpire

Set password never expire, default is $true.

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserName

The name of the user to create.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456193/cs.UsrMgr+CreateLocalUser


## RELATED LINKS

{{ Fill in the related links here }}

