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
title: Get-CCSADOUStructure
---

# Get-CCSADOUStructure

## SYNOPSIS

Retrieves the Organizational Unit (OU) structure from Active Directory using the CCS Web Service.

## SYNTAX

### __AllParameterSets

```
Get-CCSADOUStructure [[-DomainTopPath] <string>] [-Domain] <string> [-Url] <string>
 [-CCSCredential] <pscredential> [[-DomainCredential] <pscredential>]
 [[-ExcludedOUNames] <string[]>] [-PasswordIsEncrypted] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Retrieves the hierarchical Organizational Unit (OU) structure from Active Directory using the CCS Web Service.
Returns a nested structure of OUs with their names, paths, and child OUs.
This advanced function includes comprehensive error handling and input validation.

## EXAMPLES

### EXAMPLE 1

Get-CCSADOUStructure -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Retrieves the complete OU structure for the domain using default CCS context.

### EXAMPLE 2

Get-CCSADOUStructure -DomainTopPath "DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

Retrieves the OU structure starting from the domain root using specific domain credentials.

### EXAMPLE 3

Get-CCSADOUStructure -DomainTopPath "OU=IT,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Retrieves the OU structure starting from a specific OU.

### EXAMPLE 4

Get-CCSADOUStructure -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -ExcludedOUNames @("Test", "Archive")

Retrieves the OU structure excluding OUs named "Test" or "Archive".

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

The domain to query for OU structure.
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

### -DomainTopPath

The top-level domain path to start the OU structure retrieval from.
Must be in DN format (DC=example,DC=com).
If not specified, retrieves from the root of the domain.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- TopPath
- BasePath
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

### -ExcludedOUNames

An array of OU names to exclude from the structure.
OUs with these names will not be included in the results.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Exclude
- ExcludeOUs
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

### System.Collections.Generic.List[PSCustomObject]
Returns a hierarchical list of OU structures containing:
- Name: OU name
- Path: Full DN path
- Children: Nested list of child OUs

{{ Fill in the Description }}

### System.Collections.Generic.List`1[[System.Management.Automation.PSObject, System.Management.Automation, Version=7.4.6.500, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]

{{ Fill in the Description }}

## NOTES

This is an advanced function with comprehensive error handling.
The function returns a hierarchical structure that can be traversed to view the complete OU tree.


## RELATED LINKS

{{ Fill in the related links here }}

