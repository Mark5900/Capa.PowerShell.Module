---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Utilities-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.Utilities
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Move-CapaDeviceToPoint
---

# Move-CapaDeviceToPoint

## SYNOPSIS

Moves a device from its current Management Point to the specified Management Point.

## SYNTAX

### __AllParameterSets

```
Move-CapaDeviceToPoint [-CapaSDK] <Object> [-DeviceUUID] <Object> [-PointName] <Object>
 [-ManagementServerFQDN] <Object> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Moves a device from its current Management Point to the specified Management Point.
If a Management Server is specified, the device will be linked to it.

All relations to the device in the old Management Point will be removed, including but not limited to packages, profiles, applications, groups, folders, primary user, user relations, management server.

## EXAMPLES

### EXAMPLE 1

Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'TestManagementPoint' -ManagementServerFQDN 'TestManagementServer'

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

### -DeviceUUID

The UUID of the device.

```yaml
Type: System.Object
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

### -ManagementServerFQDN

The name of the Management Server the device should be linked to.
If an empty string is specified, the device will not be linked to a Management Server after the move.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### -PointName

The name of the Management Point the device should be moved to.

```yaml
Type: System.Object
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247640/Move+Device+To+Management+Point


## RELATED LINKS

{{ Fill in the related links here }}

