# TODO: Update and add tests

<#
	.SYNOPSIS
		Resets the last run date on a global task.

	.DESCRIPTION
		Returns the last run date on a global task.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER TaskDisplayName
		The display name of the task. Can be one of the following:
			Auto Archive Changelog
			Cleanup Performance Index Data
			Clear Changeset
			Clear Deleted Units
			Group Health Check
			Inventory Cleanup
			Process Metering History
			Process SQL groups
			System Health
			Update Active Directory Groups
			Update Application Groups
			Update OS Version
			Update Unit Commands
			Update Unlicensed Software Queries

	.EXAMPLE
		PS C:\> Reset-CapaLastRunDateOnGlobalTask -CapaSDK $CapaSDK -TaskDisplayName 'Auto Archive Changelog'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247152/Reset+LastRun+Date+On+Global+Task
#>
function Reset-CapaLastRunDateOnGlobalTask {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Auto Archive Changelog', 'Cleanup Performance Index Data', 'Clear Changeset', 'Clear Deleted Units', 'Group Health Check', 'Inventory Cleanup', 'Process Metering History', 'Process SQL groups', 'System Health', 'Update Active Directory Groups', 'Update Application Groups', 'Update OS Version', 'Update Unit Commands', 'Update Unlicensed Software Queries')]
		[string]$TaskDisplayName
	)

	$value = $CapaSDK.ResetLastRunOnGlobalTask($TaskDisplayName)
	return $value
}
