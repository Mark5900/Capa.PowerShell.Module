# TODO: Update and add tests

<#
	.SYNOPSIS
		Counts the number of conscom actions.

	.DESCRIPTION
		Counts the number of conscom actions.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ManagementServerID
		The management server ID to check for. If omitted, conscom actions for all servers are counted.

	.EXAMPLE
		PS C:\> Count-CapaConscomActions -CapaSDK $CapaSDK -ManagementServerID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247078/Count+conscom+actions
#>
function Count-CapaConscomActions {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ManagementServerID
	)

	$value = $CapaSDK.CountConscomActions($ManagementServerID)
	return $value
}
