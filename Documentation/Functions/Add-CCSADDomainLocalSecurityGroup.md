# Add-CCSADDomainLocalSecurityGroup

Module: Capa.PowerShell.Module.CCS

## SYNOPSIS
Creates a domain local security group in Active Directory.

## SYNTAX

```
Add-CCSADDomainLocalSecurityGroup [-GroupName] <String> [[-Description] <String>] [[-DomainOUPath] <String>]
 [-Domain] <String> [-Url] <String> [-CCSCredential] <PSCredential> [[-DomainCredential] <PSCredential>]
 [[-PasswordIsEncrypted] <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a domain local security group in Active Directory using the CCS Web Service.

## EXAMPLES

### EXAMPLE 1
```
Add-CCSADDomainLocalSecurityGroup -GroupName 'TestGroup' -Description 'Test Description' -DomainOUPath 'OU=Groups,DC=example,DC=com' -Domain 'example.com' -Url 'https://example.com/CCSWebservice/CCS.asmx' -CCSCredential $CCSCredential -DomainCredential $DomainCredential -PasswordIsEncrypted $false
```

## PARAMETERS

### -CCSCredential
The credentials used to authenticate with the CCS Web Service.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
A description for the security group.

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

### -Domain
The domain in which the security group will be created.

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

### -DomainCredential
The credentials of an account with permissions to create the security group, if not defined it will run in the CCSWebservice context.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainOUPath
The Organizational Unit (OU) path in which the security group will be created.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
The name of the security group to be created.

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

### -PasswordIsEncrypted
Indicates if the password in the DomainCredential is encrypted.
Default is false.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Position: 5
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
