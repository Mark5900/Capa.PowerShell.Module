---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Job-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Job
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Job_WriteLog
---

# Job_WriteLog

## SYNOPSIS

This function will write a log entry.

## SYNTAX

### __AllParameterSets

```
Job_WriteLog [-Text] <string> [[-FunctionName] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function will write a log entry.

## EXAMPLES

### EXAMPLE 1

Job_WriteLog -FunctionName "Install" -Text "Installing application"

### EXAMPLE 2

Log_SectionHeader -Name "Install"
PS C:\> Job_WriteLog -Text "Installing application"

## PARAMETERS

### -FunctionName

Name of function to associate with log entry (default blank, Log_Sectionheader will override).

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

### -Text

The text to write to the log.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455683/cs.Job+WriteLog


## RELATED LINKS

{{ Fill in the related links here }}

