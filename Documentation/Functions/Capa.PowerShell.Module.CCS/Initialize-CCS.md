---
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.CCS
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Initialize-CCS
---

# Initialize-CCS

## SYNOPSIS

This function initializes the CCS Webservice client.

## SYNTAX

### __AllParameterSets

```
Initialize-CCS [-Url] <string> [-WebServiceCredential] <pscredential> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function initializes the CCS Webservice client by loading the necessary DLL and setting up the binding and endpoint.
It also sets the client credentials for authentication.

## EXAMPLES

### EXAMPLE 1

Initialize-CCS -Url "https://example.com/CCSWebservice/CCS.asmx" -WebServiceCredential $Credential

## PARAMETERS

### -Url

The URL of the CCS Webservice.

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

### -WebServiceCredential

The credentials used to authenticate with the CCS Webservice.

```yaml
Type: System.Management.Automation.PSCredential
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

## RELATED LINKS

{{ Fill in the related links here }}

