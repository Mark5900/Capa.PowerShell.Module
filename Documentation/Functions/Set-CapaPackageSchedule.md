# Set-CapaPackageSchedule
Module: Capa.PowerShell.Module.SDK.Package

Sets the schedule of a package.

## Syntax

```powershell
Set-CapaPackageSchedule
	-CapaSDK <Object>
	-PackageName <String>
	-PackageVersion <String>
	-PackageType <String>
	-ScheduleStart <String>
	-ScheduleEnd <String>
	-ScheduleIntervalBegin <String>
	-ScheduleIntervalEnd <String>
	-ScheduleRecurrence <String>
	-ScheduleRecurrencePattern <String>
```

## Description

Sets the schedule of a package.

## Examples

### Example 1
```powershell
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
    

## Parameters

-**CapaSDK**

The CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageName**

The name of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 2 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageVersion**

The version of the package.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PackageType**

The type of the package, either Computer or User.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScheduleStart**

The start date of the schedule, for example '2015-05-15 12:00'.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScheduleEnd**

The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg. "2015-04-15 12:05". If no end date is wanted, leave empty.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScheduleIntervalBegin**

The Schedule Interval begins time in the format  HH:mm" eg. "06:00". If left empty it is set to 00:00.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScheduleIntervalEnd**

The Schedule Interval end time in the format  HH:mm" eg. "12:00". If left empty it is set to 00:00.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 8 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScheduleRecurrence**

The Schedule Recurrence for the schedule, either Once, PeriodicalDaily, PeriodicalWeekly or Always.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 9 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ScheduleRecurrencePattern**

Is used to further detail the Schedule Recurrence when set to PeriodicalDaily or PeriodicalWeekly
	Possible values:
	ScheduleRecurrence = "PeriodicalDaily"
		ScheduleRecurrencePattern  = "RecurEveryWeekDay" sets the recurrence pattern to run every weekday
		ScheduleRecurrencePattern  = "" Sets the recurrence pattern to recur every day including weekend days.
	
	ScheduleRecurrence = "PeriodicalWeekly"
		ScheduleRecurrencePattern   = "1,3,5" Will set the schedule pattern to run Monday, Wednesday and Friday. All weekdays can be combined with a comma (,) (1,2,3,4,5,6,7)
			Monday = 1
			Tuesday = 2
			Wednesday = 3
			Thursday = 4
			Friday = 5
			Saturday = 6
			Sunday = 7
		ScheduleRecurrencePattern   = "" Will set the schedule recurrence pattern to run every weekday
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 10 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule
