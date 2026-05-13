---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+isUserMemberOf
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.CCS
ms.date: 05/13/2026
PlatyPS schema version: 2024-05-01
title: Test-CCSADIsUserMemberOfGroup
---

# Test-CCSADIsUserMemberOfGroup

## SYNOPSIS

Tests if a user is a member of a security group in Active Directory using the CCS Web Service.

## SYNTAX

### __AllParameterSets

```
Test-CCSADIsUserMemberOfGroup [-UserName] <string> [-GroupName] <string> -Domain <string>
 -Url <string> -CCSCredential <pscredential> [-DomainOUPath <string>]
 [-DomainCredential <pscredential>] [-PasswordIsEncrypted] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Tests if a user is a member of a security group in Active Directory using the CCS Web Service.
This advanced function includes comprehensive error handling and input validation.

## EXAMPLES

### EXAMPLE 1

Test-CCSADIsUserMemberOfGroup -UserName "jdoe" -GroupName "IT-Admins" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Tests if user 'jdoe' is a member of 'IT-Admins' group using default CCS context.

### EXAMPLE 2

Test-CCSADIsUserMemberOfGroup -UserName "jdoe" -GroupName "IT-Admins" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

Tests if user 'jdoe' is a member of 'IT-Admins' group using specific domain credentials and OU path.

### EXAMPLE 3

Test-CCSADIsUserMemberOfGroup -UserName "jdoe" -GroupName "IT-Admins" -DomainOUPath "LDAP://DC01.Firmax.local/DC=Firmax,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Tests group membership using LDAP format for the OU path.
The LDAP path will be automatically converted to standard DN format.

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

### -Domain

The domain in which the user resides.
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

The credentials of the user account to check for group membership.
If not provided, uses the CCS Web Service context.

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

The Organizational Unit (OU) path in which the user resides.
If not specified, searches the entire domain.
Supports both standard DN format (OU=Users,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Users,DC=example,DC=com).

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

The name of the security group to check membership for.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Group
- SecurityGroupName
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

### -UserName

The username to check for group membership.
This should be the user's login name (samAccountName).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Name
- User
- SamAccountName
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

{{ Fill in the Description }}

## OUTPUTS

### System.Boolean
Returns $true if the user is a member of the group

{{ Fill in the Description }}

### System.Boolean

{{ Fill in the Description }}

## NOTES

This is an advanced function with comprehensive error handling.
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+isUserMemberOf


## RELATED LINKS

- [](https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+isUserMemberOf)
