---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.Tools-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.Tools
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Write-LogLine
---

# Write-LogLine

## SYNOPSIS

Use to write a line to the log file.

## SYNTAX

### __AllParameterSets

```
Write-LogLine [-Text] <string> [[-ScriptPart] <string>] [[-ForegroundColor] <Object>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Used to write a  pretty line to the log file indstead of using Write-Host or Write-Output.

## EXAMPLES

### EXAMPLE 1

Write-LogLine -Text 'value1'

### EXAMPLE 2

Write-LogLine -Text 'value1' -ScriptPart 'Function1'

### EXAMPLE 3

Write-LogLine -Text 'value1' -ScriptPart 'Function1' -ForegroundColor 'Red'

## PARAMETERS

### -ForegroundColor

The color of the text.
Only usable to see in the console.

```yaml
Type: System.Object
DefaultValue: (Get-Host).ui.rawui.ForegroundColor
SupportsWildcards: false
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

### -ScriptPart

The part of the script that is writing to the log file.
Default value is 'Main'.

```yaml
Type: System.String
DefaultValue: Main
SupportsWildcards: false
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

The text to write to the log file.

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

This is a custom function created to have a standard way of starting logging in SDK scripts.


## RELATED LINKS

{{ Fill in the related links here }}

