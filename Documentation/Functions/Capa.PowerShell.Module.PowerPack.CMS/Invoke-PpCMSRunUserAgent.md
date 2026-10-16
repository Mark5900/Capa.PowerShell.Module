---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.CMS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.CMS
ms.date: 10/16/2026
PlatyPS schema version: 2024-05-01
title: Invoke-PpCMSRunUserAgent
---

# Invoke-PpCMSRunUserAgent

## SYNOPSIS

Sends a CallHomeUser UnitCommand to the BaseAgent which in turn will request the InfoCenter to run the Agent script in the user context.

## SYNTAX

### __AllParameterSets

```
Invoke-PpCMSRunUserAgent [[-Delay] <string>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Sends a CallHomeUser UnitCommand to the BaseAgent which in turn will request the InfoCenter to run the Agent script in the user context.

## EXAMPLES

### EXAMPLE 1

$bStatus = Invoke-PpCMSRunUserAgent -Delay "10s"
if ($bStatus) {
	Job_WriteLog -Text "User Agent has been set to run in 10 seconds."
} else {
	Job_WriteLog -Text "Failed to set User Agent to run in 10 seconds."
}

## PARAMETERS

### -Delay

If the delay is empty, the command will be set to now.
Delay examples: 10s (in 10 seconds), 5m (5 minutes) or 1h20m (1 hour and 20 minutes)

```yaml
Type: System.String
DefaultValue: ''
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

## RELATED LINKS

{{ Fill in the related links here }}

