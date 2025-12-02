---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: Initialize-PpVariables
---

# Initialize-PpVariables

## SYNOPSIS

Initialize global variables

## SYNTAX

### __AllParameterSets

```
Initialize-PpVariables [[-DllPath] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Initialize global variables

## EXAMPLES

### EXAMPLE 1

Initialize-PpVariables -DllPath 'C:\Program Files (x86)\CapaOne\Scripting Library\CapaOne.ScriptingLibrary.dll'

## PARAMETERS

### -DllPath

The path to the CapaOne.ScriptingLibrary.dll.

```yaml
Type: System.String
DefaultValue: $Global:DllPath
SupportsWildcards: false
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Command from PSlib.psm1


## RELATED LINKS

{{ Fill in the related links here }}

