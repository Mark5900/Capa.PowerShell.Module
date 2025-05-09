---
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.CCS
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Get-CCSEncryptedPassword
---

# Get-CCSEncryptedPassword

## SYNOPSIS

This function encrypts a string using the InstallationScreen.exe utility.

## SYNTAX

### __AllParameterSets

```
Get-CCSEncryptedPassword [-String] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function takes a string as input and uses the InstallationScreen.exe utility to encrypt it.
The encrypted string is returned as output and used multiple times, when working with the CCS Webservice.

## EXAMPLES

### EXAMPLE 1

Get-CCSEncryptedPassword -String "Admin1234"

## PARAMETERS

### -String

The string to be encrypted.

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

## RELATED LINKS

{{ Fill in the related links here }}

