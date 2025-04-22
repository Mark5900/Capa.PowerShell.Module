# Add-CCSADUniversalSecurityGroup

Module: Capa.PowerShell.Module.CCS

## SYNOPSIS
Adds a Universal Security Group to Active Directory.

## SYNTAX

```
Add-CCSADUniversalSecurityGroup [-GroupName] <String> [[-Description] <String>] [[-DomainOUPath] <String>]
 [-Domain] <String> [-Url] <String> [-CCSCredential] <PSCredential> [[-DomainCredential] <PSCredential>]
 [[-PasswordIsEncrypted] <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Adds a Universal Security Group to Active Directory.

## EXAMPLES

### EXAMPLE 1
```
Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'Test Description' -DomainOUPath 'OU=Groups,DC=example,DC=com' -Domain 'example.com' -Url 'https://example.com/CCSWebservice/CCS.asmx' -CCSCredential $CCSCredential -DomainCredential $DomainCredential -PasswordIsEncrypted $false
```

## PARAMETERS

### -CCSCredential
The credentials for the CCS Web Service.

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
The description of the group.

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
The domain where the group will be created.

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
The credentials for the domain.

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
The Organizational Unit (OU) path where the group will be created.

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
The name of the group to be created.

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
Indicates whether the AD password is encrypted.

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
