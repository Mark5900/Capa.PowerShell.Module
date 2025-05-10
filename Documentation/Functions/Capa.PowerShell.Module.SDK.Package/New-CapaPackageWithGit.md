---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Package-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.Package
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: New-CapaPackageWithGit
---

# New-CapaPackageWithGit

## SYNOPSIS

Creates a new capa package with Git support

## SYNTAX

### NotAdvanced

```
New-CapaPackageWithGit -PackageName <string> -PackageVersion <string> -PackageType <string>
 -BasePath <string> [-CapaServer <string>] [-SQLServer <string>] [-Database <string>]
 [-DefaultManagementPoint <string>] [-PackageBasePath <string>] [<CommonParameters>]
```

### Advanced

```
New-CapaPackageWithGit -SoftwareName <string> -SoftwareVersion <string> -PackageType <string>
 -BasePath <string> -Advanced [-CapaServer <string>] [-SQLServer <string>] [-Database <string>]
 [-DefaultManagementPoint <string>] [-PackageBasePath <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Creates a local folder structure you can use with Git to manage your deployment of Capa packages.
There is both a simple and advanced mode.

It is recommended to read the documentation before using this function.
https://github.com/Mark5900/Capa.PowerShell.Module/tree/main/Documentation

## EXAMPLES

### EXAMPLE 1

New-CapaPackageWithGit -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'VBScript' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs'

### EXAMPLE 2

New-CapaPackageWithGit -SoftwareName 'Test1' -SoftwareVersion 'v1.0' -PackageType 'PowerPack' -BasePath 'C:\Temp' -CapaServer 'CISERVER' -SQLServer 'CISERVER' -Database 'CapaInstaller' -DefaultManagementPoint '1' -PackageBasePath 'E:\CapaInstaller\CMPProduction\ComputerJobs' -Advanced

## PARAMETERS

### -Advanced

When specified the advanced setup will be used

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: Advanced
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -BasePath

The base path where the package folder will be created

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CapaServer

The Capa server name

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Database

The Capa database name

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DefaultManagementPoint

The default management point

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageBasePath

The path of where CapaInstaller is saving the packages, example E:\CapaInstaller\CMPProduction\ComputerJobs

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageName

The name of the package

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: NotAdvanced
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageType

The type of the package, either VBScript or PowerPack

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
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

The version of the package

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: NotAdvanced
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SoftwareName

The name of the software

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: Advanced
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SoftwareVersion

The version of the software

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: Advanced
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SQLServer

The SQL server name

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
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

This is a custom function that is not part of the CapaSDK


## RELATED LINKS

{{ Fill in the related links here }}

