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
title: Test-PpCMSExistPackageOnManagementServer
---

# Test-PpCMSExistPackageOnManagementServer

## SYNOPSIS

Checks if the specified package exists on the management server the agent is connected to.

## SYNTAX

### __AllParameterSets

```
Test-PpCMSExistPackageOnManagementServer [-PackageName] <string> [-PackageVersion] <string>
 [[-MustExist] <bool>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Checks if the specified package exists on the management server the agent is connected to.

## EXAMPLES

### EXAMPLE 1

$bStatus = Test-PpCMSExistPackageOnManagementServer -PackageName "MyPackage" -PackageVersion "1.0.0"
if ($bStatus) {
	Job_WriteLog -Text "Package exists on management server."
} else {
	Job_WriteLog -Text "Package does not exist on management server."
}

## PARAMETERS

### -MustExist

If the package must exist or not.
Default is false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageName

The name of the package to check for.

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

The version of the package to check for.

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

