---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.Package-Help.xml
HelpUri: ''
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.Package
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Set-CapaPackageSchedule
---

# Set-CapaPackageSchedule

## SYNOPSIS

Sets the schedule of a package.

## SYNTAX

### __AllParameterSets

```
Set-CapaPackageSchedule [-CapaSDK] <Object> [-PackageName] <string> [-PackageVersion] <string>
 [-PackageType] <string> [-ScheduleStart] <string> [[-ScheduleEnd] <string>]
 [[-ScheduleIntervalBegin] <string>] [[-ScheduleIntervalEnd] <string>]
 [-ScheduleRecurrence] <string> [[-ScheduleRecurrencePattern] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Sets the schedule of a package.

## EXAMPLES

### EXAMPLE 1

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

## PARAMETERS

### -CapaSDK

The CapaSDK object.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageName

The name of the package.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageType

The type of the package, either Computer or User.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageVersion

The version of the package.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ScheduleEnd

The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg.
"2015-04-15 12:05".
If no end date is wanted, leave empty.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ScheduleIntervalBegin

The Schedule Interval begins time in the format  HH:mm" eg.
"06:00".
If left empty it is set to 00:00.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ScheduleIntervalEnd

The Schedule Interval end time in the format  HH:mm" eg.
"12:00".
If left empty it is set to 00:00.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ScheduleRecurrence

The Schedule Recurrence for the schedule, either Once, PeriodicalDaily, PeriodicalWeekly or Always.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 8
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
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
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 9
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ScheduleStart

The start date of the schedule, for example '2015-05-15 12:00'.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule


## RELATED LINKS

{{ Fill in the related links here }}

