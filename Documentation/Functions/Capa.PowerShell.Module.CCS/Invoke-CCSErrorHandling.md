---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.CCS
ms.date: 05/12/2026
PlatyPS schema version: 2024-05-01
title: Invoke-CCSErrorHandling
---

# Invoke-CCSErrorHandling

## SYNOPSIS

Throws a structured error with proper error records for CCS operations.

## SYNTAX

### __AllParameterSets

```
Invoke-CCSErrorHandling [-ErrorMessage] <string> [-ErrorCategory <ErrorCategory>]
 [-TargetObject <Object>] [-FunctionName <string>] [-Exception <Exception>]
 [-RecommendedAction <string>] [-LogToCs <bool>] [-Throw <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function creates and throws a properly formatted PowerShell error with appropriate
error categories, target objects, and detailed error messages.
It also logs to the global
Cs object if available and supports different error severity levels.

## EXAMPLES

### EXAMPLE 1

Invoke-CCSErrorHandling -ErrorMessage "Failed to connect to CCS Web Service" -ErrorCategory ConnectionError -TargetObject $Url

Throws a connection error with the specified message.

### EXAMPLE 2

Invoke-CCSErrorHandling -ErrorMessage "Computer not found in AD" -ErrorCategory ObjectNotFound -TargetObject $ComputerName -RecommendedAction "Verify the computer name exists in Active Directory"

Throws an object not found error with a recommended action.

### EXAMPLE 3

Invoke-CCSErrorHandling -ErrorMessage "Invalid credentials" -ErrorCategory AuthenticationError -Throw:$false

Writes a non-terminating authentication error.

## PARAMETERS

### -ErrorCategory

The PowerShell error category.
Default is 'OperationStopped'.
Valid values: NotSpecified, OpenError, CloseError, DeviceError, DeadlockDetected, InvalidArgument,
InvalidData, InvalidOperation, InvalidResult, InvalidType, MetadataError, NotImplemented,
NotInstalled, ObjectNotFound, OperationStopped, OperationTimeout, SyntaxError, ParserError,
PermissionDenied, ResourceBusy, ResourceExists, ResourceUnavailable, ReadError, WriteError,
FromStdErr, SecurityError, ProtocolError, ConnectionError, AuthenticationError, LimitsExceeded,
QuotaExceeded, NotEnabled.

```yaml
Type: System.Management.Automation.ErrorCategory
DefaultValue: OperationStopped
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ErrorMessage

The main error message to display.

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

### -Exception

An existing exception object to wrap in the error record.

```yaml
Type: System.Exception
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FunctionName

The name of the function where the error occurred.
If not specified, uses the calling function's name.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -LogToCs

Whether to log the error to the global Cs object.
Default is $true.

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -RecommendedAction

Recommended action for the user to resolve the error.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TargetObject

The object that was being processed when the error occurred.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Throw

Whether to throw the error (terminating) or write it as a non-terminating error.
Default is $true (throw).

```yaml
Type: System.Boolean
DefaultValue: True
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
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

### None. This function either throws a terminating error or writes a non-terminating error.

{{ Fill in the Description }}

## NOTES

This function provides consistent error handling across all CCS module functions.


## RELATED LINKS

{{ Fill in the related links here }}

