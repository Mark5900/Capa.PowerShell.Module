---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Winget-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Winget
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Find-PpWinGetCmd
---

# Find-PpWinGetCmd

## SYNOPSIS

Find the path to the WinGet executable.

## SYNTAX

### __AllParameterSets

```
Find-PpWinGetCmd [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Find the path to the WinGet executable.
If the WinGet executable is not found, the function will return $false.

## EXAMPLES

### EXAMPLE 1

$WingetPath = Find-PpWinGetCmd

### EXAMPLE 2

$WingetPath = Find-PpWinGetCmd -AllowInstallOfWinGet $true

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Custom function not from CapaSystems.
Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1


## RELATED LINKS

{{ Fill in the related links here }}

