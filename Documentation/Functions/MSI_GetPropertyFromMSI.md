# MSI_GetPropertyFromMSI

Module: Capa.PowerShell.Module.PowerPack.MSI

## SYNOPSIS
Gets the value of a property from an MSI file.

## SYNTAX

```
MSI_GetPropertyFromMSI [-MsiFile] <String> [-Property] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
MSI_GetPropertyFromMSI -MsiFile "C:\Temp\test.msi" -Property "ProductVersion"
```

## PARAMETERS

### -MsiFile
The path to the MSI file.

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

### -Property
The property to get the value from.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455734/cs.MSI+GetPropertyFromMSI

## RELATED LINKS
