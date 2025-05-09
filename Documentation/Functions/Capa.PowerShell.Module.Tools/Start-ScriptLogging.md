---
document type: cmdlet
external help file: Capa.PowerShell.Module.Tools-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.Tools
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Start-ScriptLogging
---

# Start-ScriptLogging

## SYNOPSIS

This fuction is used to start logging of a SDK script.

## SYNTAX

### __AllParameterSets

```
Start-ScriptLogging [-Path] <string> [[-UseDateInFileName] <bool>] [[-UseTimeInFileName] <bool>]
 [[-UseStopwatch] <bool>] [[-DeleteDaysOldLogs] <int>] [[-LogName] <string>]
 [[-DeleteAllLogs] <bool>] [[-AppendToLog] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This fuction is used to start logging of a SDK script.
The log file will be stored in a folder named Logs_<LogName> in the path specified.
You can get the path to the log file by using the global variable $Global:SDKScriptLogfile.

## EXAMPLES

### EXAMPLE 1

Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module'

### EXAMPLE 2

Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseDateInFileName False

### EXAMPLE 3

Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseTimeInFileName False

### EXAMPLE 4

Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseStopwatch False

### EXAMPLE 5

Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -DeleteDaysOldLogs 1

## PARAMETERS

### -AppendToLog

Default is true.
If set to false a new log file will be created.

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DeleteAllLogs

Default is false.
If set to true all logs will be deleted.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DeleteDaysOldLogs

Sets the number of days old logs should be deleted.
Default is 90 days.

```yaml
Type: System.Int32
DefaultValue: 90
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

### -LogName

Sets the name of the log file.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Path

Defines the path to the folder where the log file should be stored.
In most cases this should be $PSScriptRoot.

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

### -UseDateInFileName

Default is true.
If set to false the date will not be used in the log file name.

```yaml
Type: System.Boolean
DefaultValue: True
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

### -UseStopwatch

Default is true.
If set to false the stopwatch will not be used in the log file.

```yaml
Type: System.Boolean
DefaultValue: True
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

### -UseTimeInFileName

Default is true.
If set to false the time will not be used in the log file name.

```yaml
Type: System.Boolean
DefaultValue: True
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

