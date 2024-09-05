# Reg_EnumKey

Module: Capa.PowerShell.Module.PowerPack.Reg

## SYNOPSIS
Enumerates all registry keys.

## SYNTAX

```
Reg_EnumKey [-RegRoot] <String> [-RegPath] <String> [[-MustExist] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems"
```

### EXAMPLE 2
```
Reg_EnumKey -RegRoot "HKLM" -RegPath "SOFTWARE\CapaSystems" -MustExist $false
```

## PARAMETERS

### -MustExist
Indicates if the registry key must exist, default is $true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: True
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

### -RegPath
The path of the registry key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RegRoot
The root of the registry key, can be HKLM, HKCU or HKU.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455853/cs.Reg+EnumKey

## RELATED LINKS
