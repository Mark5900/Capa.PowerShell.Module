---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Sys-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.Sys
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Sys_IsMinimumRequiredDiskspaceAvailable
---

# Sys_IsMinimumRequiredDiskspaceAvailable

## SYNOPSIS

Checks if a minimum required disk space is available.

## SYNTAX

### __AllParameterSets

```
Sys_IsMinimumRequiredDiskspaceAvailable [[-Drive] <string>] [-MinimumRequiredDiskspaceInMb] <int>
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function checks if the specified drive has at least the minimum required disk space available.

## EXAMPLES

### EXAMPLE 1

Sys_IsMinimumRequiredDiskspaceInMbAvailable -MinimumRequiredDiskspaceInMb 1000

### EXAMPLE 2

Sys_IsMinimumRequiredDiskspaceInMbAvailable -Drive "D:" -MinimumRequiredDiskspaceInMb 1000

## PARAMETERS

### -Drive

The drive to check, default is 'C:'.

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

### -MinimumRequiredDiskspaceInMb

The minimum required disk space in bytes.

```yaml
Type: System.Int32
DefaultValue: 0
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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456108/cs.Sys+IsMinimumRequiredDiskspaceAvailable


## RELATED LINKS

{{ Fill in the related links here }}

