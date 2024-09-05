# UsrMgr_CreateLocalUser

## SYNOPSIS
Create a local user account.

## SYNTAX

```
UsrMgr_CreateLocalUser [-UserName] <String> [-FullName] <String> [-Password] <String> [[-Description] <String>]
 [[-PasswordNeverExpire] <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd"
```

### EXAMPLE 2
```
UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd" -Description "This is a test user."
```

### EXAMPLE 3
```
UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd" -PasswordNeverExpire $false
```

## PARAMETERS

### -Description
The description of the user to create.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FullName
The full name of the user to create.

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

### -Password
The password of the user to create.

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

### -PasswordNeverExpire
Set password never expire, default is $true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

### -UserName
The name of the user to create.

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
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456193/cs.UsrMgr+CreateLocalUser

## RELATED LINKS
