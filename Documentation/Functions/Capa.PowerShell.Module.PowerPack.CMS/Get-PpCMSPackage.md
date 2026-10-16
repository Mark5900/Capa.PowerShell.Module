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
title: Get-PpCMSPackage
---

# Get-PpCMSPackage

## SYNOPSIS

Returns the specified package.

## SYNTAX

### __AllParameterSets

```
Get-PpCMSPackage [-PackageName] <string> [-PackageVersion] <string>
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the specified package, with the following data:
- Serverdeploy
- Platform
- Dependendpackageid
- Id
- Name
- Version
- Type
- Scheduleid
- Ismandatory
- Isinteractive
- Synchronizepriority
- Displayname
- Description
- Capapackid
- Capapackupdate
- Capapackupdates
- Capapackappid
- Capapackdateadded
- Isinventorypackage
- Iscapapack
- Iscapapackandcanbeupdated
- Priority
- Icon
- Cmpid
- Release
- Script
- Swiid
- Inactiveperiod
- Hasinstallscript
- Hasuninstallscript
- Haspostscript
- Hasuserconfigurationscript
- Devicetypeid
- Devicetype
- Advertisementtag
- Ispowerpack
- Installscriptcontent
- Uninstallscriptcontent
- Postscriptcontent
- Userconfigscriptcontent
- Linkedunitcount
- Linkedgroupcount
- Folderid
- Folderpath
- Statuscancelledcount
- Statusinstallingcount
- Statusfailedcount
- Statusuninstallcount
- Statuswaitingcount
- Scheduleactive
- Guid
- Objecttype

## EXAMPLES

### EXAMPLE 1

$package = Get-PpCMSPackage -PackageName "MyPackage" -PackageVersion "1.0.0"
if ($package) {
	Job_WriteLog -Text "Package found."
} else {
	Job_WriteLog -Text "Package not found."
}

## PARAMETERS

### -PackageName

The name of the package to get.

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

The version of the package to get.

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

