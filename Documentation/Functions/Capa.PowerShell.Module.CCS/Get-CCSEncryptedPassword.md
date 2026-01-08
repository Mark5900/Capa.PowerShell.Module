---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.CCS
ms.date: 01/08/2026
PlatyPS schema version: 2024-05-01
title: Get-CCSEncryptedPassword
---

# Get-CCSEncryptedPassword

## SYNOPSIS

Encrypts a SecureString using the InstallationScreen.exe utility for CCS Webservice use.

## SYNTAX

### __AllParameterSets

```
Get-CCSEncryptedPassword [-SecureString] <securestring> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Takes a SecureString and uses the InstallationScreen.exe utility to encrypt it.
Returns the encrypted string, suitable for use with CCS Webservice operations.
Includes robust error handling, parameter validation, and advanced function features.

## EXAMPLES

### EXAMPLE 1

$secure = ConvertTo-SecureString "Admin1234" -AsPlainText -Force
Get-CCSEncryptedPassword -SecureString $secure

## PARAMETERS

### -SecureString

The SecureString to encrypt.
Must not be empty.

```yaml
Type: System.Security.SecureString
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Password
- Secret
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
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

### System.Security.SecureString

{{ Fill in the Description }}

## OUTPUTS

### System.String. The encrypted string.

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## NOTES

Advanced function with CmdletBinding, error handling, and pipeline support.


## RELATED LINKS

{{ Fill in the related links here }}

