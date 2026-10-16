---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack
ms.date: 10/16/2026
PlatyPS schema version: 2024-05-01
title: Initialize-PpInputObject
---

# Initialize-PpInputObject

## SYNOPSIS

Initialize the InputObject object.

## SYNTAX

### __AllParameterSets

```
Initialize-PpInputObject
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Used in PowerPacks to initialize the InputObject object, if it is not already initialized.
If you run a PowerPack script locally, then InputObject is null and you can use this function create a obejct to test your script.

The only thing that does not work is CMS functions, because they need a real InputObject object.
The message box is also not the real one, but a simple example.

## EXAMPLES

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

