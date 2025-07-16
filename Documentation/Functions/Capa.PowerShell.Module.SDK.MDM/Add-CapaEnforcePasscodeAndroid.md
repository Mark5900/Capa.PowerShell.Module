---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.MDM-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.SDK.MDM
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Add-CapaEnforcePasscodeAndroid
---

# Add-CapaEnforcePasscodeAndroid

## SYNOPSIS

Add a new Enforce Passcode payload or edit an existing one.

## SYNTAX

### __AllParameterSets

```
Add-CapaEnforcePasscodeAndroid [-CapaSDK] <Object> [-ProfileId] <int> [-Passcode] <string>
 [[-ChangelogComment] <Object>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Add a new Enforce Passcode payload or edit an existing payload in the specified profile.

## EXAMPLES

### EXAMPLE 1

Add-CapaEnforcePasscodeAndroid -CapaSDK $CapaSDK -ProfileId 1 -Passcode '12345678' -ChangelogComment 'Adding Enforce Passcode payload to profile'

## PARAMETERS

### -CapaSDK

The CapaSDK object.

```yaml
Type: System.Object
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

### -ChangelogComment

The comment you wish to be added to the changelog.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Passcode

The passcode to enforce.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
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

### -ProfileId

The ID of the profile to add the payload to.

```yaml
Type: System.Int32
DefaultValue: 0
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246520/Add+edit+Enforce+Passcode+Android


## RELATED LINKS

{{ Fill in the related links here }}

