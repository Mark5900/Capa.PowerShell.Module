---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.CMS-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.CMS
ms.date: 10/16/2026
PlatyPS schema version: 2024-05-01
title: Get-PpCMSDeploymentTemplateVariable
---

# Get-PpCMSDeploymentTemplateVariable

## SYNOPSIS

Returns a variable from the deployment template linked to the current client

## SYNTAX

### __AllParameterSets

```
Get-PpCMSDeploymentTemplateVariable [[-Section] <string>] [-Variable] <string> [[-MustExist] <bool>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns a variable from the deployment template from which the client was installed.
Alternatively, the
template is fetched from the business unit that the client was linked to at installation time.

## EXAMPLES

### EXAMPLE 1

$value = Get-PpCMSDeploymentTemplateVariable -Variable "title" -MustExist $true
Job_WriteLog -Text "Title: $value"

### EXAMPLE 2

$value = Get-PpCMSDeploymentTemplateVariable -Section "domain" -Variable "joinDomain" -MustExist $true
Job_WriteLog -Text "Join domain: $value"

## PARAMETERS

### -MustExist

True if the variable must exist, defaults is false

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
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

### -Section

The name of the section in the template

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

### -Variable

The name of the variable to return

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Example configutation:
{
	"operatingSystem": {
		"ImageId": 13,
		"diskConfigId": 1,
		"localAdmin": "true",
		"password": "15aarest"
	},
	"domain": {
		"joinDomain": "CAPADEMO.LOCAL",
		"domainName": "CAPADEMO.LOCAL",
		"domainUserName": "ciinst",
		"domainUserPassword": "dftgyhuj",
		"computerObjectOU": "OU=Computers,OU=Lazise,OU=Dev2,DC=CAPADEMO,DC=local"},
	"title": "Default",
	"customValues": [{
		"key": "a",
		"value": "1"
	}]
}


## RELATED LINKS

{{ Fill in the related links here }}

