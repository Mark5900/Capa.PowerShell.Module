# Uninstall-PpWingetApp

## SYNOPSIS
Uninstalls an application using winget.

## SYNTAX

```
Uninstall-PpWingetApp [-AppId] <String> [[-AllowInstallOfWinGet] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Uninstalls an application using winget.

## EXAMPLES

### EXAMPLE 1
```
Uninstall-PpWingetApp -AppId 'Mozilla.Firefox'
```

### EXAMPLE 2
```
Uninstall-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true
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
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppId
The id of the application to uninstall.
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

## RELATED LINKS
