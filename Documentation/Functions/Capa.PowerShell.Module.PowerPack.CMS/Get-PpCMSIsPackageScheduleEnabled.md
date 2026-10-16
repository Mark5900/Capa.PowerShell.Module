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
title: Get-PpCMSIsPackageScheduleEnabled
---

# Get-PpCMSIsPackageScheduleEnabled

## SYNOPSIS

Returns as boolean indicating if the schedule for a package is enabled.

## SYNTAX

### __AllParameterSets

```
Get-PpCMSIsPackageScheduleEnabled [-PackageName] <string> [-PackageVersion] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns as boolean indicating if the schedule for a package is enabled.

## EXAMPLES

### EXAMPLE 1

$bStatus = Get-PpCMSIsPackageScheduleEnabled -PackageName "Adobe Reader" -PackageVersion "11.0.00"
if ($bStatus) {
	Write-Host "Package schedule is enabled."
} else {
	Write-Host "Package schedule is not enabled."
}

## PARAMETERS

### -PackageName

The name of the package.

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

The version of the package.

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

## RELATED LINKS

{{ Fill in the related links here }}

