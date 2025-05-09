---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Exit-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.Exit
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Exit-PpScript
---

# Exit-PpScript

## SYNOPSIS

Exit the script with a given exit code and message.

## SYNTAX

### __AllParameterSets

```
Exit-PpScript [-ExitCode] <Object> [[-ExitMessage] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Exit the script with a given exit code and message.

## EXAMPLES

### EXAMPLE 1

Exit-PpScript -ExitCode 0 -ExitMessage "Script ended successfully"

### EXAMPLE 2

Exit-PpScript -ExitCode 3305

## PARAMETERS

### -ExitCode

The exit code to exit the script with.

```yaml
Type: System.Object
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

### -ExitMessage

The message to write to the log before exiting the script.

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

## NOTES

Command from PSlib.psm1


## RELATED LINKS

{{ Fill in the related links here }}

