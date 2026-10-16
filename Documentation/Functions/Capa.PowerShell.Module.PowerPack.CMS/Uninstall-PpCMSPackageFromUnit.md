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
title: Uninstall-PpCMSPackageFromUnit
---

# Uninstall-PpCMSPackageFromUnit

## SYNOPSIS

Uninstalls package from unit.

## SYNTAX

### ID

```
Uninstall-PpCMSPackageFromUnit -PackageID <string>
```

### NameVersion

```
Uninstall-PpCMSPackageFromUnit -PackageName <string> -PackageVersion <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Uninstalls package from unit.

## EXAMPLES

### EXAMPLE 1

$bStatus = Uninstall-PpCMSPackageFromUnit -PackageID 1234
if ($bStatus) {
	Job_WriteLog -Text "Package uninstalled"
} else {
	Job_WriteLog -Text "Failed to uninstall package"
}

### EXAMPLE 2

$bStatus = Uninstall-PpCMSPackageFromUnit -PackageName 'MyPackage' -PackageVersion 'v1.0'
if ($bStatus) {
	Job_WriteLog -Text "Package uninstalled"
} else {
	Job_WriteLog -Text "Failed to uninstall package"
}

## PARAMETERS

### -PackageID

ID of the package (JobId from the JOB table).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ID
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageName

Name of the package.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: NameVersion
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageVersion

Version of the package.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: NameVersion
  Position: Named
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

