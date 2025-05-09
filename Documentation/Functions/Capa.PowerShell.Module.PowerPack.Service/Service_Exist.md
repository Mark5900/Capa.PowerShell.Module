---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Service-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.Service
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Service_Exist
---

# Service_Exist

## SYNOPSIS

Determines if a service exists.

## SYNTAX

### __AllParameterSets

```
Service_Exist [-ServiceName] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function checks if a service exists on the system.

## EXAMPLES

### EXAMPLE 1

Service_Exist -ServiceName "W32Time"

## PARAMETERS

### -ServiceName

The name of the service.

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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455989/cs.Service+Exist


## RELATED LINKS

{{ Fill in the related links here }}

