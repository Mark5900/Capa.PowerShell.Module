# Get-PpWingetReturnCodeDescription

## SYNOPSIS
Get the error message for a WinGet error code.

## SYNTAX

```
Get-PpWingetReturnCodeDescription [-Decimal] <Int32> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get the error message for a WinGet error code.

## EXAMPLES

### EXAMPLE 1
```
Get-PpWingetReturnCodeDescription -Decimal -1978335231
```

## PARAMETERS

### -Decimal
The error code in decimal.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
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
Source: https://github.com/microsoft/winget-cli/blob/master/doc/windows/package-manager/winget/returnCodes.md

## RELATED LINKS
