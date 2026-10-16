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
title: Get-PpCMSGroupMembership
---

# Get-PpCMSGroupMembership

## SYNOPSIS

Returns an array of the groups to which the client is linked.

## SYNTAX

### __AllParameterSets

```
Get-PpCMSGroupMembership
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns an array of the groups to which the client is linked, containing values:
- Packagetype
- Parentid
- Unittype
- Id
- Name
- Description
- Type
- Typedisplayname
- Icon
- Cmpid
- Scheduleid
- Groupdeleted
- Businessunitid
- Linkedprofilecount
- Linkedapplicationcount
- Linkedpackagecount
- Linkedunitcount
- Folderid
- Guid
- Objecttype

## EXAMPLES

### EXAMPLE 1

$groups = Get-PpCMSGroupMembership
foreach ($group in $groups) {
	Job_WriteLog -Text "Group: $($group.Name)"
}

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

