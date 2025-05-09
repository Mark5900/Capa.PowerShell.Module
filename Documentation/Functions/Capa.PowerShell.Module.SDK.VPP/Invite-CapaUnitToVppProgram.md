---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.VPP-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.VPP
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Invite-CapaUnitToVppProgram
---

# Invite-CapaUnitToVppProgram

## SYNOPSIS

Creates a VPP user at Apple where an invitation URL is generated. This invitation is then sent to the device where the user will have the option to accept or decline.

## SYNTAX

### __AllParameterSets

```
Invite-CapaUnitToVppProgram [-CapaSDK] <Object> [-VppProgramID] <int> [-UnitID] <int>
 [-UserFullName] <string> [-UserEmailName] <string> [-UserDescription] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Creates a VPP user at Apple where an invitation URL is generated.
This invitation is then sent to the device where the user will have the option to accept or decline.
If the user accepts the invitation, its Apple ID will be linked to the VPP user at Apple, which can be seen in the system after the next synchronization cycle.

There are a few requirements for the operation to succeed.
	The device must be running iOS8 or higher.
	The device should not already be enrolled in the Volume Purchase Program specified.
	If an invitation previously sent to the device was not accepted, a VPP user will already exist at Apple.
In order to avoid creating multiple VPP users, the system will reuse that original invitation and send it to the device again.

## EXAMPLES

### EXAMPLE 1

Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 1 -UserFullName 'Test User' -UserEmailName 'Test@test.com' -UserDescription 'Test User'

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

### -UnitID

The id of the iOS device which should receive an invitation.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -UserDescription

The description of the vpp user being created.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserEmailName

The email of the vpp user being created.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### -UserFullName

The fullname of the vpp user being created.

```yaml
Type: System.String
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

### -VppProgramID

The VPP user will be created in the program with the specified id.

```yaml
Type: System.Int32
DefaultValue: 0
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247828/Invite+unit+to+vpp


## RELATED LINKS

{{ Fill in the related links here }}

