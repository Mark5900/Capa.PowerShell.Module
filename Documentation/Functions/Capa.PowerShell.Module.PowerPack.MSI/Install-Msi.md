---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.MSI-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.MSI
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Install-Msi
---

# Install-Msi

## SYNOPSIS

Installs an MSI file.

## SYNTAX

### __AllParameterSets

```
Install-Msi [-FilePath] <string> [[-Arguments] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Installs an MSI file.

## EXAMPLES

### EXAMPLE 1

Install-Msi -FilePath 'C:\Temp\MyApp.msi' -Arguments '/qn'

## PARAMETERS

### -Arguments

Additional arguments to pass to the MSI installer.
By default the MSI is called with arguments to log the installation to a file.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
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

### -FilePath

The path to the MSI file.

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

## RELATED LINKS

{{ Fill in the related links here }}

