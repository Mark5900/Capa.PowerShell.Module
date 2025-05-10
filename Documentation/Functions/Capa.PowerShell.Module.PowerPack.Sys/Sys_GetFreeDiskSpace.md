---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Sys-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Sys
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Sys_GetFreeDiskSpace
---

# Sys_GetFreeDiskSpace

## SYNOPSIS

Gets the free disk space of a drive.

## SYNTAX

### __AllParameterSets

```
Sys_GetFreeDiskSpace [[-Drive] <string>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function retrieves the free disk space of the specified drive.

## EXAMPLES

### EXAMPLE 1

Sys_GetFreeDiskSpace

### EXAMPLE 2

Sys_GetFreeDiskSpace -Drive "D:"

## PARAMETERS

### -Drive

The drive to get the free disk space from, default is 'C:'.

```yaml
Type: System.String
DefaultValue: 'C:'
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

## INPUTS

## OUTPUTS

## NOTES

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456057/cs.Sys+GetFreeDiskSpace


## RELATED LINKS

{{ Fill in the related links here }}

