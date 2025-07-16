---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.Tools-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.Tools
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Invoke-DownloadCapaPackage
---

# Invoke-DownloadCapaPackage

## SYNOPSIS

Downloads a Capa package from CI server using the BaseAgent.

## SYNTAX

### __AllParameterSets

```
Invoke-DownloadCapaPackage [-PackageName] <string> [-PackageVersion] <string>
 [-DestinationFolder] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Downloads a Capa package from server using the BaseAgent.

## EXAMPLES

### EXAMPLE 1

Invoke-DownloadCapaPackage -PackageName 'CP CapaDrivers Latitude 5440' -PackageVersion 'W10 Custom' -DestinationFolder 'c:\temp\Test'

## PARAMETERS

### -DestinationFolder

The folder where the package will be downloaded and extracted to.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageName

The name of the package to download.

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

### -PackageVersion

The version of the package to download.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
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

This function requires the Capa BaseAgent to be installed on the machine.


## RELATED LINKS

{{ Fill in the related links here }}

