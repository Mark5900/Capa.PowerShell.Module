# Remove-CCSADComputer

Module: Capa.PowerShell.Module.CCS

## SYNOPSIS
Remove a computer from Active Directory using the CCS Web Service.

## SYNTAX

```
Remove-CCSADComputer [-ComputerName] <String> [[-DomainOUPath] <String>] [-Domain] <String> [-Url] <String>
 [-CCSCredential] <PSCredential> [[-DomainCredential] <PSCredential>] [[-PasswordIsEncrypted] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Removes a computer from Active Directory using the CCS Web Service.
This function requires the CCS Web Service URL and credentials to access it.

## EXAMPLES

### EXAMPLE 1
```
Remove-CCSADComputer -ComputerName "TestPC" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential
```

### EXAMPLE 2
```
Remove-CCSADComputer -ComputerName "TestPC" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential
```

## PARAMETERS

### -CCSCredential
The credentials used to authenticate with the CCS Web Service.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
The name of the computer to be removed from Active Directory.

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

### -Domain
The domain in which the computer resides.

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

### -DomainCredential
The credentials of an account with permissions to remove the computer from Active Directory, if not defined it will run in the CCSWebservice context.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainOUPath
The Organizational Unit (OU) path in which the computer resides.

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

### -PasswordIsEncrypted
Indicates if the password in the DomainCredential is encrypted.
Default is false.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
The URL of the CCS Web Service.
Example "https://example.com/CCSWebservice/CCS.asmx".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
