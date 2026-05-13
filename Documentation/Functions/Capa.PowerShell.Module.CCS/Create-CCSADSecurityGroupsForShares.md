---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.CCS
ms.date: 05/12/2026
PlatyPS schema version: 2024-05-01
title: Create-CCSADSecurityGroupsForShares
---

# Create-CCSADSecurityGroupsForShares

## SYNOPSIS

Creates Active Directory security groups for network shares using the CCS Web Service.

## SYNTAX

### __AllParameterSets

```
Create-CCSADSecurityGroupsForShares [[-DomainOUPath] <string>] [-Domain] <string> [-Url] <string>
 [-CCSCredential] <pscredential> [[-DomainCredential] <pscredential>] [-GroupFormat] <string>
 [-GroupDescriptionFormat] <string> [-CreateReadGroup] [-CreateReadWriteGroup]
 [-ExcludeStandardShares] [-PasswordIsEncrypted] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Creates Active Directory security groups for network shares using the CCS Web Service.
This advanced function includes comprehensive error handling, input validation, and supports creating both read and read/write groups.
The function can automatically create security groups based on share names with customizable group name and description formats.

## EXAMPLES

### EXAMPLE 1

Create-CCSADSecurityGroupsForShares -GroupFormat "Share_`$sharename`$" -GroupDescriptionFormat "Access to `$sharename`$" -CreateReadGroup -CreateReadWriteGroup -ExcludeStandardShares -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Creates both read and read/write groups for all shares (excluding standard shares) using default CCS context.

### EXAMPLE 2

Create-CCSADSecurityGroupsForShares -DomainOUPath "OU=ShareGroups,DC=example,DC=com" -GroupFormat "FS_`$sharename`$" -GroupDescriptionFormat "File share: `$sharename`$ (`$localpath`$)" -CreateReadGroup -CreateReadWriteGroup -ExcludeStandardShares -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

Creates groups in a specific OU with custom format including local path in description.

### EXAMPLE 3

Create-CCSADSecurityGroupsForShares -GroupFormat "RO_`$sharename`$" -GroupDescriptionFormat "Read-only access to `$shareunc`$" -CreateReadGroup -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Creates only read groups for all shares.

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
  Position: 3
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

### -CreateReadGroup

If specified, creates a read-only group (suffix: _R) for each share.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- Read
- ReadOnly
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

### -CreateReadWriteGroup

If specified, creates a read/write group (suffix: _RW) for each share.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- ReadWrite
- RW
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

### -Domain

The domain in which the security groups will be created.
Must be a valid domain name format.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DomainCredential

The credentials of an account with permissions to create security groups in Active Directory.
If not defined, it will run in the CCS Web Service context.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ADCredential
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

### -DomainOUPath

The Organizational Unit (OU) path where the security groups will be created.
If not specified, groups will be created in the default location.
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
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ExcludeStandardShares

If specified, excludes standard Windows shares (C$, ADMIN$, IPC$, etc.) from group creation.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- ExcludeStandard
- SkipStandardShares
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

### -GroupDescriptionFormat

The format string for the group description.
Use placeholders: $sharename$, $sharecaption$, $shareunc$, $localpath$
Example: "Access to $sharename$ share at $shareunc$"

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- DescriptionFormat
- Description
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -GroupFormat

The format string for the group name.
Use placeholders: $sharename$, $sharecaption$
Example: "Share_$sharename$" will create groups like "Share_Data_R" and "Share_Data_RW"

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Format
- NameFormat
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: true
  ValueFromPipeline: false
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
Must be a valid HTTPS URI format.
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
  Position: 2
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

### System.String

{{ Fill in the Description }}

## OUTPUTS

### System.String
Returns the result message from the CCS Web Service operation.

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## NOTES

This is an advanced function with support for ShouldProcess, comprehensive error handling, and detailed logging.
Group name suffixes: _R (read-only), _RW (read/write)
Available placeholders: $sharename$, $sharecaption$, $shareunc$, $localpath$


## RELATED LINKS

{{ Fill in the related links here }}

