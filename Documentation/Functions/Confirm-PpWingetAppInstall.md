# Confirm-PpWingetAppInstall

## SYNOPSIS
Confirm if an app is installed.

## SYNTAX

```
Confirm-PpWingetAppInstall [-AppId] <String> [[-WingetPath] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Confirm if an app is installed.
Returns $true if the app is installed, otherwise $false.

## EXAMPLES

### EXAMPLE 1
```
Confirm-PpWingetAppInstall -AppId 'Microsoft.VisualStudioCode'
```

## PARAMETERS

### -AppId
The AppId of the app to confirm.

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

### -WingetPath
The path to the winget executable.
If not provided, the function will try to find the winget executable.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Custom function not from CapaSystems.
Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1

## RELATED LINKS
