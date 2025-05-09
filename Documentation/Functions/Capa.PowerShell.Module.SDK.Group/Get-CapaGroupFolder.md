---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Group-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.Group
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Get-CapaGroupFolder
---

# Get-CapaGroupFolder

## SYNOPSIS

Gets the folder structure of a group.

## SYNTAX

### __AllParameterSets

```
Get-CapaGroupFolder [-CapaSDK] <Object> [-GroupName] <string> [-GroupType] <string>
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns a string with the folder structure of a group.
Someting like: "Folder1\Folder2".

## EXAMPLES

### EXAMPLE 1

Get-CapaGroupFolder -CapaSDK $CapaSDK -GroupName 'Default' -GroupType Dynamic_ADSI

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

### -GroupName

The name of the group.

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

### -GroupType

The type of the group, either Dynamic_ADSI, Department, Dynamic_SQL or Static.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580985/Get+Group+Folder


## RELATED LINKS

{{ Fill in the related links here }}

