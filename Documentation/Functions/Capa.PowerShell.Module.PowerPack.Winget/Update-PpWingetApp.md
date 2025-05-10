---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Winget-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Winget
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Update-PpWingetApp
---

# Update-PpWingetApp

## SYNOPSIS

Updates an application using winget.

## SYNTAX

### __AllParameterSets

```
Update-PpWingetApp [-AppId] <string> [[-Locale] <string>] [[-UninstallPrevious] <bool>]
 [[-AllowInstallOfWinGet] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Updates an application using winget.

## EXAMPLES

### EXAMPLE 1

Update-PpWingetApp -AppId 'Mozilla.Firefox'

### EXAMPLE 2

Update-PpWingetApp -AppId 'Mozilla.Firefox' -Locale 'da-DK'

### EXAMPLE 3

Update-PpWingetApp -AppId 'Mozilla.Firefox' -UninstallPrevious $true

### EXAMPLE 4

Update-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true

## PARAMETERS

### -AllowInstallOfWinGet

Allow the installation of winget if it is not installed.
Or update winget if it is installed.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AppId

The id of the application to update.
You can find all the available applications on https://winget.run

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

### -Locale

The locale to use for the installation, for example 'da-DK'

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UninstallPrevious

Uninstall the previous version of the package during upgrade.Behavior will depend on the individual package.
Some installers are designed to install new versions side-by-side.
Some installers include a manifest that specifies “uninstallPrevious” so earlier versions are uninstalled without needing to use this command flag.
In this case, using the winget upgrade --uninstall-previous command will tell WinGet to uninstall the previous version regardless of what is in the package manifest.
If the package manifest does not include “uninstallPrevious” and the --uninstall-previous flag is not used, then the default behavior for the installer will apply.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

