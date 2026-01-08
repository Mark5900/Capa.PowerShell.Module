---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.CCS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.CCS
ms.date: 01/08/2026
PlatyPS schema version: 2024-05-01
title: Get-CCSADLastLoginForComputers
---

# Get-CCSADLastLoginForComputers

## SYNOPSIS

Retrieves last login information for all computers in Active Directory using the CCS Web Service.

## SYNTAX

### __AllParameterSets

```
Get-CCSADLastLoginForComputers [[-DomainOUPath] <string>] [-Domain] <string> [-Url] <string>
 [-CCSCredential] <pscredential> [[-DomainCredential] <pscredential>] [-PasswordIsEncrypted]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Retrieves comprehensive last login information for all computers in Active Directory using the CCS Web Service.
Returns computer name, last logon time, last logon DC, operating system, and AD path for each computer.
This advanced function includes comprehensive error handling and input validation.

## EXAMPLES

### EXAMPLE 1

Get-CCSADLastLoginForComputers -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Retrieves last login information for all computers in the domain using default CCS context.

### EXAMPLE 2

Get-CCSADLastLoginForComputers -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

Retrieves last login information for all computers in a specific OU using domain credentials.

### EXAMPLE 3

Get-CCSADLastLoginForComputers -DomainOUPath "LDAP://DC01.Firmax.local/OU=Servers,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Retrieves last login information using LDAP format for the OU path.
The LDAP path will be automatically converted to standard DN format.

### EXAMPLE 4

$computers = Get-CCSADLastLoginForComputers -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential
PS C:\> $computers | Where-Object { $_.LastLogon -lt (Get-Date).AddDays(-30) }

Retrieves all computers and filters for those that haven't logged in for 30 days.

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

### -Domain

The domain to query for computer information.
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

The Organizational Unit (OU) path to search for computers.
If not specified, searches the entire domain.
Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

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
  Position: 0
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

### System.String

{{ Fill in the Description }}

## OUTPUTS

### System.Collections.Generic.List[ADComputerInfo]
Returns a list of ADComputerInfo objects containing:
- Name: Computer name
- LastLogon: Last logon timestamp
- LastLogonDC: Domain controller where last logon occurred
- OperatingSystem: Operating system version
- Path: Active Directory path

{{ Fill in the Description }}

### System.Collections.Generic.List`1[[System.Management.Automation.PSObject, System.Management.Automation, Version=7.4.6.500, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]

{{ Fill in the Description }}

## NOTES

This is an advanced function with comprehensive error handling.
The function returns a strongly-typed list of computer objects from Active Directory.


## RELATED LINKS

{{ Fill in the related links here }}

