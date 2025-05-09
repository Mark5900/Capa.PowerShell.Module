---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Sys-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.Sys
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Sys_ExistProcess
---

# Sys_ExistProcess

## SYNOPSIS

Checks if a process exists.

## SYNTAX

### __AllParameterSets

```
Sys_ExistProcess [-ProcessName] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function checks if a process is running on the system.

## EXAMPLES

### EXAMPLE 1

Sys_ExistProcess -ProcessName "notepad.exe"

## PARAMETERS

### -ProcessName

The name of the process to check.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456074/cs.Sys+ExistProcess


## RELATED LINKS

{{ Fill in the related links here }}

