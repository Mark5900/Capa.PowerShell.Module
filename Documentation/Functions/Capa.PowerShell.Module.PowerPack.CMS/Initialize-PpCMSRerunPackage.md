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
title: Initialize-PpCMSRerunPackage
---

# Initialize-PpCMSRerunPackage

## SYNOPSIS

Sets status for the specified package to 'Waiting' causing it to rerun the next time the Agent is being executed.

## SYNTAX

### __AllParameterSets

```
Initialize-PpCMSRerunPackage [-PackageName] <string> [-PackageVersion] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Sets status for the specified package to 'Waiting' causing it to rerun the next time the Agent is being executed.

## EXAMPLES

### EXAMPLE 1

$bStatus = Initialize-PpCMSRerunPackage -PackageName "MyPackage" -PackageVersion "v1.0"
if ($bStatus) {
	Job_WriteLog -Text "Package 'MyPackage' with version 'v1.0' has been set to rerun."
} else {
	Job_WriteLog -Text "Failed to set package 'MyPackage' with version 'v1.0' to rerun."
}

## PARAMETERS

### -PackageName

Name of the package to rerun.

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

Version of the package to rerun.

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

