# Get-CCSADComputerNames

Module: Capa.PowerShell.Module.CCS

## SYNOPSIS
Gets the computer names from Active Directory using the CCS API.

## SYNTAX

```
Get-CCSADComputerNames [[-DomainOUPath] <String>] [-Domain] <String> [-Url] <String>
 [-CCSCredential] <PSCredential> [[-DomainCredential] <PSCredential>] [[-PasswordIsEncrypted] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Gets the computer names from Active Directory using the CCS API.

## EXAMPLES

### EXAMPLE 1
```
Get-CCSADComputerNames -DomainOUPath "OU=Test,DC=FirmaX,DC=local" -Domain "FirmaX.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $ccsCredential -DomainCredential $domainCredential
```

## PARAMETERS

### -CCSCredential
The credentials for the CCS API.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
The domain name where the computers reside.

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

### -DomainCredential
The credentials for the domain where the computers reside.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainOUPath
The Organizational Unit (OU) path of the domain where the computers reside.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordIsEncrypted
Indicates whether the password is encrypted.
Default is $false.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
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

### -Url
The URL of the CCS API.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
