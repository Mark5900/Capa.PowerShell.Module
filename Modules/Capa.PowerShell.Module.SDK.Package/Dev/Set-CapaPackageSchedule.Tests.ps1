BeforeAll {
	. $PSScriptRoot\Set-CapaPackageSchedule.ps1
}

Describe 'Set-CapaPackageSchedule' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod SetPackageSchedule {
			param($PackageName, $PackageVersion, $PackageType, $ScheduleStart, $ScheduleEnd, $ScheduleIntervalBegin, $ScheduleIntervalEnd, $ScheduleRecurrence, $ScheduleRecurrencePattern)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $ScheduleStart, $ScheduleEnd, $ScheduleIntervalBegin, $ScheduleIntervalEnd, $ScheduleRecurrence, $ScheduleRecurrencePattern)
			$true
		}

		$result = Set-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -ScheduleStart '2026-01-01 12:00' -ScheduleEnd '2026-01-01 13:00' -ScheduleIntervalBegin '12:00' -ScheduleIntervalEnd '13:00' -ScheduleRecurrence 'Once' -ScheduleRecurrencePattern ''

		$result | Should -Be $true
		$script:called[0] | Should -Be 'Pkg'
		$script:called[7] | Should -Be 'Once'
	}
}
