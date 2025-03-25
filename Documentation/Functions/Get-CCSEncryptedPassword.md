# Get-CCSEncryptedPassword

Module: Capa.PowerShell.Module.CCS

## SYNOPSIS
This function encrypts a string using the InstallationScreen.exe utility.

## SYNTAX

```
Get-CCSEncryptedPassword [-String] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function takes a string as input and uses the InstallationScreen.exe utility to encrypt it.
The encrypted string is returned as output and used multiple times, when working with the CCS Webservice.

## EXAMPLES

### EXAMPLE 1
```
Get-CCSEncryptedPassword -String "Admin1234"
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

### -String
The string to be encrypted.

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

## RELATED LINKS
