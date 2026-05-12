---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+ValidateUser
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.CCS
ms.date: 05/12/2026
PlatyPS schema version: 2024-05-01
title: Confirm-CCSADUser
---

# Confirm-CCSADUser

## SYNOPSIS

Validates a user's credentials against Active Directory.

## SYNTAX

### __AllParameterSets

```
Confirm-CCSADUser [[-DomainOUPath] <string>] [-Domain] <string> [-Url] <string>
 [-CCSCredential] <pscredential> [-DomainCredential] <pscredential> [-PasswordIsEncrypted]
 [-UsePrincipalContext] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function validates a user's credentials against Active Directory using the CCS Web Service.
It can use either PrincipalContext-based validation or direct LDAP validation.

## EXAMPLES

### EXAMPLE 1

$CCSCred = Get-Credential
PS C:\> $UserCred = Get-Credential
PS C:\> Confirm-CCSADUser -Domain 'contoso.com' -Url 'https://ccs.contoso.com/CCS' -CCSCredential $CCSCred -DomainCredential $UserCred

Validates the user credentials in $UserCred against the contoso.com domain using PrincipalContext validation.

### EXAMPLE 2

Confirm-CCSADUser -DomainOUPath 'OU=Users,DC=contoso,DC=com' -Domain 'contoso.com' -Url 'https://ccs.contoso.com/CCS' -CCSCredential $CCSCred -DomainCredential $UserCred

Validates the user credentials against the specified OU in the contoso.com domain.

### EXAMPLE 3

Confirm-CCSADUser -Domain 'contoso.com' -Url 'https://ccs.contoso.com/CCS' -CCSCredential $CCSCred -DomainCredential $UserCred -UsePrincipalContext:$false

Validates the user credentials using direct LDAP validation instead of PrincipalContext.

## PARAMETERS

### -CCSCredential

The credentials used to connect to the CCS Web Service.

```yaml
Type: System.Management.Automation.PSCredential
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

### -Domain

The domain name where the user is located.

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
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DomainCredential

The credentials to validate against Active Directory.
This is the user whose credentials you want to verify.

```yaml
Type: System.Management.Automation.PSCredential
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DomainOUPath

The distinguished name or LDAP path of the OU where the user is located.
If not specified, the entire domain will be searched.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PasswordIsEncrypted

Indicates whether the password in the credentials is already encrypted.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
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

The URL of the CCS Web Service, e.g., https://ccs.example.com/CCS.

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

### -UsePrincipalContext

When specified, uses PrincipalContext-based validation.
When not specified, uses direct LDAP validation.
Default is to use PrincipalContext.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: True
SupportsWildcards: false
Aliases: []
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

### System.Management.Automation.PSCredential

{{ Fill in the Description }}

## OUTPUTS

### System.Boolean

{{ Fill in the Description }}

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+ValidateUser


## RELATED LINKS

- [](https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+ValidateUser)
