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
title: Get-PpCMSAdvertisedPackages
---

# Get-PpCMSAdvertisedPackages

## SYNOPSIS

Get a list of advertised packages.

## SYNTAX

### __AllParameterSets

```
Get-PpCMSAdvertisedPackages
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Get a list of advertised packages.
With JobId, Type, Name, Version, Uninstallscript, Catalogname, Description, Advertiseddate, Groupname and Autoexpand.

## EXAMPLES

### EXAMPLE 1

$packages = Get-PpCMSAdvertisedPackages
foreach ($package in $packages) {
	Job_WriteLog -Text "Package: $($package.PackageName) Version: $($package.PackageVersion)"
}

## PARAMETERS

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

