---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.SystemSdk-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.SystemSdk
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Get-CapaManagementPoint
---

# Get-CapaManagementPoint

## SYNOPSIS

Get management points or a specific management point.

## SYNTAX

### __AllParameterSets

```
Get-CapaManagementPoint [-CapaSDK] <Object> [[-CmpId] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

If CmpId is not specified, all management points are returned.

## EXAMPLES

### EXAMPLE 1

Get-CapaManagementPoint -CapaSDK $value1 -CmpId $value2

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

### -CmpId

The ID of the management point to return.
If omitted, all management points are returned.

```yaml
Type: System.Int32
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247106/Get+management+point
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247116/Get+management+points


## RELATED LINKS

{{ Fill in the related links here }}

