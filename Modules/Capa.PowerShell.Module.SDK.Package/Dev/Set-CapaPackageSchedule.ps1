# TODO: #186 Update and add tests

<#
	.SYNOPSIS
		Sets the schedule of a package.

	.DESCRIPTION
		Sets the schedule of a package.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.PARAMETER ScheduleStart
		The start date of the schedule, for example '2015-05-15 12:00'.

	.PARAMETER ScheduleEnd
		The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg. "2015-04-15 12:05". If no end date is wanted, leave empty.

	.PARAMETER ScheduleIntervalBegin
		The Schedule Interval begins time in the format  HH:mm" eg. "06:00". If left empty it is set to 00:00.

	.PARAMETER ScheduleIntervalEnd
		The Schedule Interval end time in the format  HH:mm" eg. "12:00". If left empty it is set to 00:00.

	.PARAMETER ScheduleRecurrence
		The Schedule Recurrence for the schedule, either Once, PeriodicalDaily, PeriodicalWeekly or Always.

	.PARAMETER ScheduleRecurrencePattern
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

	.EXAMPLE
				PS C:\> Set-CapaPackageSchedule @(
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

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247048/Set+Package+Schedule
#>
function Set-CapaPackageSchedule {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[String]$ScheduleStart,
		[Parameter(Mandatory = $false)]
		[String]$ScheduleEnd,
		[Parameter(Mandatory = $false)]
		[String]$ScheduleIntervalBegin,
		[Parameter(Mandatory = $false)]
		[String]$ScheduleIntervalEnd,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Once', 'PeriodicalDaily', 'PeriodicalWeekly', 'Always')]
		[String]$ScheduleRecurrence,
		[String]$ScheduleRecurrencePattern = ''
	)

	$value = $CapaSDK.SetPackageSchedule($PackageName, $PackageVersion, $PackageType, $ScheduleStart, $ScheduleEnd, $ScheduleIntervalBegin, $ScheduleIntervalEnd, $ScheduleRecurrence, $ScheduleRecurrencePattern)
	return $value
}
