---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.MSI-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.MSI
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Uninstall-PpMSI
---

# Uninstall-PpMSI

## SYNOPSIS

Uninstalls an MSI package by its DisplayName and optionally by its version.

## SYNTAX

### __AllParameterSets

```
Uninstall-PpMSI [-DisplayName] <string> [[-Version] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function uninstalls an MSI package from the system.
It searches for the package in the registry and executes the uninstall command.

## EXAMPLES

### EXAMPLE 1

Uninstall-PpMSI -DisplayName "MyApp" -Version "1.0.0"
This command uninstalls the MSI package with the display name "MyApp" and version "1.0.0".

### EXAMPLE 2

Uninstall-PpMSI -DisplayName "MyApp*"
This command uninstalls all MSI packages with display names that start with "MyApp".

## PARAMETERS

### -DisplayName

The display name of the MSI package to uninstall.
This parameter is mandatory.
Wildcard characters are allowed in the DisplayName parameter.

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

### -Version

The version of the MSI package to uninstall.
This parameter is optional.
If not provided, all versions of the package with the specified display name will be uninstalled.

```yaml
Type: System.String
DefaultValue: ''
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

