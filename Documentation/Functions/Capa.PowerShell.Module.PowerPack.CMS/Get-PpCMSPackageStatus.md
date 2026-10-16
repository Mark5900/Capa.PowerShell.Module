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
title: Get-PpCMSPackageStatus
---

# Get-PpCMSPackageStatus

## SYNOPSIS

Returns the package status for the specified package.

## SYNTAX

### __AllParameterSets

```
Get-PpCMSPackageStatus [-PackageName] <string> [-PackageVersion] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the package status for the specified package.
Values can be 'Installed', 'Installing', 'Waiting' 'Failed' or 'Not Scheduled'.
'Not scheduled' indicates that the package is not linked to the unit.

## EXAMPLES

### EXAMPLE 1

$status = Get-PpCMSPackageStatus -PackageName "MyPackage" -PackageVersion "1.0.0"
if ($status -eq "Installed") {
	Job_WriteLog -Text "Package is installed."
} elseif ($status -eq "Installing") {
	Job_WriteLog -Text "Package is installing."
} elseif ($status -eq "Waiting") {
	Job_WriteLog -Text "Package is waiting."
} elseif ($status -eq "Failed") {
	Job_WriteLog -Text "Package failed."
} elseif ($status -eq "Not Scheduled") {
	Job_WriteLog -Text "Package is not scheduled."
} else {
	Job_WriteLog -Text "Unknown package status."
}

## PARAMETERS

### -PackageName

The name of the package to get the status for.

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

The version of the package to get the status for.

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

