---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.Tools-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.Tools
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Invoke-BaseAgentDownloadFile
---

# Invoke-BaseAgentDownloadFile

## SYNOPSIS

Downloads a file from CI server using the BaseAgent.

## SYNTAX

### __AllParameterSets

```
Invoke-BaseAgentDownloadFile [-RemotePath] <string> [-LocalPath] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Downloads a file from server using the BaseAgent.

## EXAMPLES

### EXAMPLE 1

Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp"

### EXAMPLE 2

Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp\CapaInstaller agent.xml"

## PARAMETERS

### -LocalPath

The folder or specific path where the file will be downloaded to.

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

### -RemotePath

The path of the file to download.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

This function requires the Capa BaseAgent to be installed on the machine.


## RELATED LINKS

{{ Fill in the related links here }}

