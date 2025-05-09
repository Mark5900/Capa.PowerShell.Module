---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Authentication-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.Authentication
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Initialize-CapaSDK
---

# Initialize-CapaSDK

## SYNOPSIS

Create a new CapaSDK object that is needed for all other functions.

## SYNTAX

### __AllParameterSets

```
Initialize-CapaSDK [-Server] <string> [-Database] <string> [[-UserName] <string>]
 [[-Password] <string>] [[-DefaultManagementPoint] <string>] [[-InstanceManagementPoint] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Create a new CapaSDK object that is needed for all other functions, with the option to set the database settings and management points.

## EXAMPLES

### EXAMPLE 1

Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -DefaultManagementPoint 1

### EXAMPLE 2

Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -InstanceManagementPoint 1

### EXAMPLE 3

Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -UserName 'sa' -Password 'P@ssw0rd' -DefaultManagementPoint 1

## PARAMETERS

### -Database

The name of the database.

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

### -DefaultManagementPoint

Id of the default management point.
DO NOT USE.
This will set the management point for all SDK objects, use InstanceManagementPoint instead.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -InstanceManagementPoint

Id of the instance management point.
Sets the management point for the current SDK object.
Use DefaultManagementPoint to set the management point for all SDK objects.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### -Password

If set, the database will be accessed with the given username and password.
Default is to use Windows Authentication.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

### -Server

The name of the server where the database is located.

```yaml
Type: System.String
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

### -UserName

If set, the database will be accessed with the given username and password.
Default is to use Windows Authentication.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
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

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580733/Set+database+settings
And https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580750/Set+default+management+point
And https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580769/Set+instance+management+point
And https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580794/Set+splitter


## RELATED LINKS

{{ Fill in the related links here }}

