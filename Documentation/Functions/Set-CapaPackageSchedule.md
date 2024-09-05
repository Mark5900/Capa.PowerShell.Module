# Set-CapaPackageSchedule

## SYNOPSIS
Sets the schedule of a package.

## SYNTAX

```
Set-CapaPackageSchedule [-CapaSDK] <Object> [-PackageName] <String> [-PackageVersion] <String>
 [-PackageType] <String> [-ScheduleStart] <String> [[-ScheduleEnd] <String>]
 [[-ScheduleIntervalBegin] <String>] [[-ScheduleIntervalEnd] <String>] [-ScheduleRecurrence] <String>
 [[-ScheduleRecurrencePattern] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Sets the schedule of a package.

## EXAMPLES

### EXAMPLE 1
```
Set-CapaPackageSchedule @(
	CapaSDK = $CapaSDK
	PackageName = 'Winrar'
	PackageVersion = '5.50'
	PackageType = 'Computer'
	ScheduleStart = '2015-05-15 12:00'
	ScheduleEnd = '2015-05-15 12:00'
	ScheduleIntervalBegin = '06:00'
	ScheduleIntervalEnd = '12:00'
	ScheduleRecurrence = 'PeriodicalDaily'
	ScheduleRecurrencePattern = 'RecurEveryWeekDay'
)
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

### -PackageName
The name of the package.

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

### -PackageType
The type of the package, either Computer or User.

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

### -PackageVersion
The version of the package.

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

### -ScheduleEnd
The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg.
"2015-04-15 12:05".
If no end date is wanted, leave empty.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduleIntervalBegin
The Schedule Interval begins time in the format  HH:mm" eg.
"06:00".
If left empty it is set to 00:00.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduleIntervalEnd
The Schedule Interval end time in the format  HH:mm" eg.
"12:00".
If left empty it is set to 00:00.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduleRecurrence
The Schedule Recurrence for the schedule, either Once, PeriodicalDaily, PeriodicalWeekly or Always.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduleRecurrencePattern
Is used to further detail the Schedule Recurrence when set to PeriodicalDaily or PeriodicalWeekly
	Possible values:
	ScheduleRecurrence = "PeriodicalDaily"
		ScheduleRecurrencePattern  = "RecurEveryWeekDay" sets the recurrence pattern to run every weekday
		ScheduleRecurrencePattern  = "" Sets the recurrence pattern to recur every day including weekend days.

	ScheduleRecurrence = "PeriodicalWeekly"
		ScheduleRecurrencePattern   = "1,3,5" Will set the schedule pattern to run Monday, Wednesday and Friday.
All weekdays can be combined with a comma (,) (1,2,3,4,5,6,7)
			Monday = 1
			Tuesday = 2
			Wednesday = 3
			Thursday = 4
			Friday = 5
			Saturday = 6
			Sunday = 7
		ScheduleRecurrencePattern   = "" Will set the schedule recurrence pattern to run every weekday

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScheduleStart
The start date of the schedule, for example '2015-05-15 12:00'.

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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule

## RELATED LINKS
