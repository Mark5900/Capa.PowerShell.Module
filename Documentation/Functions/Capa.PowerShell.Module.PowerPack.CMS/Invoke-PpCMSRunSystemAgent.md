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
title: Invoke-PpCMSRunSystemAgent
---

# Invoke-PpCMSRunSystemAgent

## SYNOPSIS

Reruns the CapaInstaller Service Agent

## SYNTAX

### __AllParameterSets

```
Invoke-PpCMSRunSystemAgent [[-Delay] <string>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Sends a CallHome UnitCommand to the BaseAgent which in turn will request the Cistub service to run the Agent script in the system context.

## EXAMPLES

### EXAMPLE 1

$bStatus = Invoke-PpCMSRunSystemAgent -Delay "10s"
if ($bStatus) {
	Job_WriteLog -Text "System Agent has been set to run in 10 seconds."
} else {
	Job_WriteLog -Text "Failed to set System Agent to run in 10 seconds."
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

