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
title: Set-PpCMSPackageStatusToNotCompliant
---

# Set-PpCMSPackageStatusToNotCompliant

## SYNOPSIS

Set the status of a package to Not Compliant.

## SYNTAX

### __AllParameterSets

```
Set-PpCMSPackageStatusToNotCompliant [-PackageName] <string> [-PackageVersion] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Set the status of a package to Not Compliant.

## EXAMPLES

### EXAMPLE 1

$bStatus = Set-PpCMSPackageStatusToNotCompliant -PackageName "MyPackage" -PackageVersion "1.0.0"
if ($bStatus) {
	Job_WriteLog -Text "Package status set to Not Compliant."
} else {
	Job_WriteLog -Text "Failed to set package status to Not Compliant."
}

## PARAMETERS

### -PackageName

The name of the package to set the status for.

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

The version of the package to set the status for.

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

