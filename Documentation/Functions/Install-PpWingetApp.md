# Install-PpWingetApp

Module: Capa.PowerShell.Module.PowerPack.Winget

## SYNOPSIS
Install an application using winget

## SYNTAX

```
Install-PpWingetApp [-AppId] <String> [[-Locale] <String>] [[-AllowInstallOfWinGet] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Install an application using winget

## EXAMPLES

### EXAMPLE 1
```
Install-PpWingetApp -Id 'Mozilla.Firefox'
```

### EXAMPLE 2
```
Install-PpWingetApp -Id 'Mozilla.Firefox' -Locale 'da-DK'
```

### EXAMPLE 3
```
Install-PpWingetApp -Id 'Mozilla.Firefox' -AllowInstallOfWinGet $true
```

## PARAMETERS

### -AllowInstallOfWinGet
Allow the installation of winget if it is not installed.
Or update winget if it is installed.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppId
{{ Fill AppId Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Locale
The locale to use for the installation, for example 'da-DK'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Custom function not from CapaSystems.
Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1

## RELATED LINKS
