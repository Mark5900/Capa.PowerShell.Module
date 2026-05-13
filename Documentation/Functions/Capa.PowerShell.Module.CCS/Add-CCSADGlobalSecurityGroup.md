---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.CCS
ms.date: 05/13/2026
PlatyPS schema version: 2024-05-01
title: Add-CCSADGlobalSecurityGroup
---

# Add-CCSADGlobalSecurityGroup

## SYNOPSIS

Creates a global security group in Active Directory using the CCS Web Service.

## SYNTAX

### __AllParameterSets

```
Add-CCSADGlobalSecurityGroup [-GroupName] <string[]> -Domain <string> -Url <string>
 -CCSCredential <pscredential> [-Description <string>] [-DomainOUPath <string>]
 [-DomainCredential <pscredential>] [-PasswordIsEncrypted] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Creates a global security group in Active Directory using the CCS Web Service.
This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

## EXAMPLES

### EXAMPLE 1

Add-CCSADGlobalSecurityGroup -GroupName "TestGroup" -Description "Test Description" -DomainOUPath "OU=Groups,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

## PARAMETERS

### -CCSCredential

The credentials used to authenticate with the CCS Web Service.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Credential
- WebServiceCredential
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- cf
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Description

A description for the security group.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Desc
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Domain

The domain in which the security group will be created.
Must be a valid domain name format.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DomainCredential

The credentials of an account with permissions to create the security group.
If not defined, it will run in the CCS Web Service context.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ADCredential
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DomainOUPath

The Organizational Unit (OU) path in which the security group will be created.
Supports both standard DN format (OU=Groups,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Groups,DC=example,DC=com).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- OU
- Path
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -GroupName

The name of the security group to be created.
Supports pipeline input and accepts multiple group names.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Name
- Group
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PasswordIsEncrypted

Indicates if the password in the DomainCredential is encrypted.
Default is $false.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- Encrypted
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Url

The URL of the CCS Web Service.
Must be a valid URI format.
Example: "https://example.com/CCSWebservice/CCS.asmx"

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- WebServiceUrl
- Uri
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases:
- wi
ParameterSets:
- Name: (All)
  Position: Named
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

### System.String[]

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## OUTPUTS

### System.String
Returns the result message from the CCS Web Service operation.

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## NOTES

This is an advanced function with support for ShouldProcess, pipeline input, and comprehensive error handling.


## RELATED LINKS

{{ Fill in the related links here }}

