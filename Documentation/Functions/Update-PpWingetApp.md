# Update-PpWingetApp

Module: Capa.PowerShell.Module.PowerPack.Winget

## SYNOPSIS
Updates an application using winget.

## SYNTAX

```
Update-PpWingetApp [-AppId] <String> [[-Locale] <String>] [[-UninstallPrevious] <Boolean>]
 [[-AllowInstallOfWinGet] <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Updates an application using winget.

## EXAMPLES

### EXAMPLE 1
```
Update-PpWingetApp -AppId 'Mozilla.Firefox'
```

### EXAMPLE 2
```
Update-PpWingetApp -AppId 'Mozilla.Firefox' -Locale 'da-DK'
```

### EXAMPLE 3
```
Update-PpWingetApp -AppId 'Mozilla.Firefox' -UninstallPrevious $true
```

### EXAMPLE 4
```
Update-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true
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
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppId
The id of the application to update.
You can find all the available applications on https://winget.run

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

### -UninstallPrevious
Uninstall the previous version of the package during upgrade.Behavior will depend on the individual package.
Some installers are designed to install new versions side-by-side.
Some installers include a manifest that specifies "uninstallPrevious" so earlier versions are uninstalled without needing to use this command flag.
In this case, using the winget upgrade --uninstall-previous command will tell WinGet to uninstall the previous version regardless of what is in the package manifest.
If the package manifest does not include "uninstallPrevious" and the --uninstall-previous flag is not used, then the default behavior for the installer will apply.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
