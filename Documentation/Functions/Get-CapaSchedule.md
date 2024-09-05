# Get-CapaSchedule

## SYNOPSIS
Returns a schedule object by id.

## SYNTAX

```
Get-CapaSchedule [-CapaSDK] <Object> [-Id] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Will return something like this: 5|06-01-2011 12:00:00||0|00:00:00|1.00:00:00|Periodical|RecurEvery\[1\] weeks on \[Monday-Tuesday-Wednesday-Thursday-Friday-Saturday-Sunday\]|Weekly||True||842b2894-cdab-4a2c-905c-17ee052179db

## EXAMPLES

### EXAMPLE 1
```
Get-CapaSchedule -CapaSDK $CapaSDK -Id '5'
```

## PARAMETERS

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

### -Id
Id of the requested unit.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246132/Get+schedule

## RELATED LINKS
