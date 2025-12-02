---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Sys-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Sys
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: Sys_WaitForProcessToExist
---

# Sys_WaitForProcessToExist

## SYNOPSIS

Waits for a process to exist.

## SYNTAX

### __AllParameterSets

```
Sys_WaitForProcessToExist [-ProcessName] <string> [-MaxWaitSec] <int> [-IntervalSec] <int>
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function waits for a process to exist.
It checks the process at regular intervals until it either exists or the maximum wait time is reached.

## EXAMPLES

### EXAMPLE 1

Sys_WaitForProcessToExist -ProcessName "notepad.exe" -MaxWaitSec 10 -IntervalSec 1

## PARAMETERS

### -IntervalSec

The interval to check in seconds.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
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

### -MaxWaitSec

The maximum time to wait in seconds.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
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

### -ProcessName

The name of the process to wait for.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456142/cs.Sys+WaitForProcessToExist


## RELATED LINKS

{{ Fill in the related links here }}

