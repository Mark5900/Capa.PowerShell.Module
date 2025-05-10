---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Invoke-RunAsLoggedOnUser
---

# Invoke-RunAsLoggedOnUser

## SYNOPSIS

Runs a command as the logged on user.

## SYNTAX

### __AllParameterSets

```
Invoke-RunAsLoggedOnUser [-Command] <string> [[-UserName] <string>] [[-Arguments] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Runs a command as the logged on user, by creating a scheduled task and starting it.

## EXAMPLES

### EXAMPLE 1

Invoke-RunAsLoggedOnUser -Command 'C:\Temp\MyApp.exe' -Arguments '/silent' -UserName 'MyDomain\MyUser'

## PARAMETERS

### -Arguments

The arguments to pass to the command.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Command

The command to run.

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

### -UserName

The user name to run the command as.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
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

### System.Int32

{{ Fill in the Description }}

## NOTES

Command from PSlib.psm1


## RELATED LINKS

{{ Fill in the related links here }}

