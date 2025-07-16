---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Service-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Service
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Service_Start
---

# Service_Start

## SYNOPSIS

Starts a service.

## SYNTAX

### __AllParameterSets

```
Service_Start [-ServiceName] <string> [-MaxTimeout <Object>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function starts a service on the system.

## EXAMPLES

### EXAMPLE 1

Service_Start -ServiceName "gupdate"

### EXAMPLE 2

Service_Start -ServiceName "gupdate" -MaxTimeout 120

## PARAMETERS

### -MaxTimeout

The maximum timeout in seconds to wait for the service to start, default is 60 seconds.

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

### -ServiceName

The name of the service.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456006/cs.Service+Start


## RELATED LINKS

{{ Fill in the related links here }}

