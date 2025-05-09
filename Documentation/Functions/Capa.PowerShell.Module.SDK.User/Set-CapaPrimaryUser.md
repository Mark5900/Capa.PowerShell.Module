---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.User-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.User
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Set-CapaPrimaryUser
---

# Set-CapaPrimaryUser

## SYNOPSIS

Set the primary user on a unit.

## SYNTAX

### __AllParameterSets

```
Set-CapaPrimaryUser [-CapaSDK] <Object> [-Uuid] <string> [-UserIdentifier] <string>
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Set the primary user on a unit.

## EXAMPLES

### EXAMPLE 1

Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4' -UserIdentifier 'tbs'

## PARAMETERS

### -CapaSDK

The CapaSDK object.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### -UserIdentifier

The user that you want to set as primary on the unit, format accepted:
	SID: S-1-5-21-2955346805-1668228357-4012311724-500
	UPN: tbs@capasystems.com
	Name: tbs

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Uuid

The UUID of the unit or device.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247714/Set+Primary+User


## RELATED LINKS

{{ Fill in the related links here }}

