# Find-PpWinGetCmd

## SYNOPSIS
Find the path to the WinGet executable.

## SYNTAX

```
Find-PpWinGetCmd [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Find the path to the WinGet executable.
If the WinGet executable is not found, the function will return $false.

## EXAMPLES

### EXAMPLE 1
```
$WingetPath = Find-PpWinGetCmd
```

### EXAMPLE 2
```
$WingetPath = Find-PpWinGetCmd -AllowInstallOfWinGet $true
```

## PARAMETERS

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
