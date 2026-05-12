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
title: Add-CCSADComputerToSecurityGroup
---

# Add-CCSADComputerToSecurityGroup

## SYNOPSIS

Adds a computer to a security group in Active Directory using the CCS Web Service.

## SYNTAX

### __AllParameterSets

```
Add-CCSADComputerToSecurityGroup [-ComputerName] <string[]> [-SecurityGroupName] <string>
 -Domain <string> -Url <string> -CCSCredential <pscredential> [-DomainOUPath <string>]
 [-DomainCredential <pscredential>] [-PasswordIsEncrypted] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Adds a computer to a security group in Active Directory using the CCS Web Service.
This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

## EXAMPLES

### EXAMPLE 1

Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Adds TestPC to TestGroup using default CCS context.

### EXAMPLE 2

Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

Adds TestPC to TestGroup using specific domain credentials and OU path.

### EXAMPLE 3

"PC01", "PC02", "PC03" | Add-CCSADComputerToSecurityGroup -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Adds multiple computers to TestGroup using pipeline input.

### EXAMPLE 4

Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "LDAP://DC01.Firmax.local/DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

Adds TestPC to TestGroup using LDAP format for the OU path.
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

### -ComputerName

The name of the computer to be added to the security group.
Supports pipeline input and accepts multiple computer names.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Name
- Computer
- CN
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

### -Domain

The domain in which the computer resides.
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

The credentials of an account with permissions to add the computer to the security group.
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

The Organizational Unit (OU) path in which the computer resides.
If not specified, searches the entire domain.
Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

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

### -SecurityGroupName

The name of the security group to which the computer will be added.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- GroupName
- Group
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

