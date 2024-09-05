# Create-CapaGroup

## SYNOPSIS
Create a group.

## SYNTAX

```
Create-CapaGroup [-CapaSDK] <Object> [-GroupName] <String> [-GroupType] <String> [-UnitType] <String>
 [[-BusinessUnit] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Create a group, either in global scope or in a business unit.

## EXAMPLES

### EXAMPLE 1
```
Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer
```

### EXAMPLE 2
```
Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer -BusinessUnit 'Denmark'
```

## PARAMETERS

### -BusinessUnit
The name of the business unit to create the group in, if not specified the group will be created in global scope.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CapaSDK
The CapaSDK object.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
The name of the group.

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

### -GroupType
The type of the group, either Calendar, Department or Static.

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

### -UnitType
The type of elements in the group, either Computer or User.

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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246224/Create+group
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246232/Create+group+in+Business+Unit

## RELATED LINKS
