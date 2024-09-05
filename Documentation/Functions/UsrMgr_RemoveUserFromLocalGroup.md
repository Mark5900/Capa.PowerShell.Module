# UsrMgr_RemoveUserFromLocalGroup

Module: Capa.PowerShell.Module.PowerPack.UsrMgr

## SYNOPSIS
Remove a user from a local group.

## SYNTAX

```
UsrMgr_RemoveUserFromLocalGroup [[-Domain] <Object>] [-UserName] <String> [-GroupName] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
UsrMgr_RemoveUserFromLocalGroup -UserName "JohnDoe" -GroupName "Administrators"
```

## PARAMETERS

### -Domain
{{ Fill Domain Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
The name of the group to remove the user from.

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
The name of the user to remove from the group.

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
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456244/cs.UsrMgr+RemoveUserFromLocalGroup

## RELATED LINKS
