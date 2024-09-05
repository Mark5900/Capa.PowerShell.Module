# UsrMgr_AddUserToLocalGroup

## SYNOPSIS
Adds a user to a local group.

## SYNTAX

```
UsrMgr_AddUserToLocalGroup [-UserName] <String> [-GroupName] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "Administrators"
```

### EXAMPLE 2
```
UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "S-1-5-32-544"
```

## PARAMETERS

### -GroupName
The name of the group to add the user to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: SID

Required: True
Position: 2
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

### -UserName
The name of the user to add to the group.

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
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456159/cs.UsrMgr+AddUserToLocalGroup

## RELATED LINKS
