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
title: Add-CapaKeyValueToAppConfigIOS
---

# Add-CapaKeyValueToAppConfigIOS

## SYNOPSIS

Add a new key/value setting to an existing AppConfig payload in the specified profile.

## SYNTAX

### __AllParameterSets

```
Add-CapaKeyValueToAppConfigIOS [-CapaSDK] <Object> [-DeviceApplicationID] <int> [-Key] <string>
 [-Value] <string> [-KeyValueType] <string> [[-ChangelogComment] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Add a new Key/Value setting to an existing AppConfig payload in the specified profile.
If a setting with the specified key and type already exists, its value will be overwritten with the new value instead of creating a new setting.

## EXAMPLES

### EXAMPLE 1

Add-CapaKeyValueToAppConfigIOS -CapaSDK $CapaSDK -DeviceApplicationID 1 -Key 'AllowSync' -Value 'True' -KeyValueType 'Boolean' -ChangelogComment 'Adding new key/value setting to AppConfig payload'

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
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DeviceApplicationID

The id of the Device Application you wish to edit.

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

### -Key

The Key of the new setting.

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

### -KeyValueType

The type of the new setting.
Valid types are: String, Boolean, Int, Float, DateTime.
(DateTime format: dd-MM-yyyy HH:mm:ss).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Value

The Value of the new setting.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246542/Add+edit+Key+Value+setting+to+iOS+AppConfig


## RELATED LINKS

{{ Fill in the related links here }}

