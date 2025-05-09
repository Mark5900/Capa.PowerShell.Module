---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.SystemSdk-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.SystemSdk
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Reset-CapaLastRunDateOnGlobalTask
---

# Reset-CapaLastRunDateOnGlobalTask

## SYNOPSIS

Resets the last run date on a global task.

## SYNTAX

### __AllParameterSets

```
Reset-CapaLastRunDateOnGlobalTask [-CapaSDK] <Object> [-TaskDisplayName] <string>
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the last run date on a global task.

## EXAMPLES

### EXAMPLE 1

Reset-CapaLastRunDateOnGlobalTask -CapaSDK $CapaSDK -TaskDisplayName 'Auto Archive Changelog'

## PARAMETERS

### -CapaSDK

The CapaSDK object.

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

### -TaskDisplayName

The display name of the task.
Can be one of the following:
	Auto Archive Changelog
	Cleanup Performance Index Data
	Clear Changeset
	Clear Deleted Units
	Group Health Check
	Inventory Cleanup
	Process Metering History
	Process SQL groups
	System Health
	Update Active Directory Groups
	Update Application Groups
	Update OS Version
	Update Unit Commands
	Update Unlicensed Software Queries

```yaml
Type: System.String
DefaultValue: ''
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247152/Reset+LastRun+Date+On+Global+Task


## RELATED LINKS

{{ Fill in the related links here }}

