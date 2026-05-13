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
title: Get-CCSADCustomAttributeForUser
---

# Get-CCSADCustomAttributeForUser

## SYNOPSIS

Gets a custom attribute value for a user from Active Directory using the CCS Web Service.

## SYNTAX

### __AllParameterSets

```
Get-CCSADCustomAttributeForUser [-UserName] <string[]> [-Attribute] <string> -Domain <string>
 -Url <string> -CCSCredential <pscredential> [-DomainOUPath <string>]
 [-DomainCredential <pscredential>] [-PasswordIsEncrypted] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Retrieves a custom attribute value for a user from Active Directory using the CCS Web Service.
This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

## EXAMPLES

### EXAMPLE 1

Get-CCSADCustomAttributeForUser -UserName "jdoe" -Attribute "department" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Gets the department attribute for user jdoe using default CCS context.

### EXAMPLE 2

Get-CCSADCustomAttributeForUser -UserName "jdoe" -Attribute "extensionAttribute1" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

Gets a custom extension attribute for user jdoe using specific domain credentials and OU path.

### EXAMPLE 3

"jdoe", "asmith", "bjones" | Get-CCSADCustomAttributeForUser -Attribute "employeeID" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Gets the employeeID attribute for multiple users using pipeline input.

### EXAMPLE 4

Get-CCSADCustomAttributeForUser -UserName "jdoe" -Attribute "title" -DomainOUPath "LDAP://DC01.Firmax.local/OU=Users,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Gets the title attribute for user jdoe using LDAP format for the OU path.
The LDAP path will be automatically converted to standard DN format.

## PARAMETERS

### -Attribute

The name of the custom attribute to retrieve.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- AttributeName
- Property
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

The credentials of an account with permissions to query Active Directory.
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
- SearchBase
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

The username of the user to retrieve the attribute for.
Supports pipeline input and accepts multiple usernames.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- User
- SamAccountName
- Identity
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

### System.String[]

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## OUTPUTS

### System.String
Returns the value of the specified custom attribute.

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## NOTES

This is an advanced function with support for pipeline input and comprehensive error handling.


## RELATED LINKS

{{ Fill in the related links here }}

