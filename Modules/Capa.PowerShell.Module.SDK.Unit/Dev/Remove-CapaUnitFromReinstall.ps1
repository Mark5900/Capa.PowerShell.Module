# TODO: #229 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247680/Remove+unit+from+reinstall

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromReinstall function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER ComputerName
		A description of the ComputerName parameter.

	.EXAMPLE
				PS C:\> Remove-CapaUnitFromReinstall -CapaSDK $value1 -ComputerName 'Value2'

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromReinstall {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$ComputerName
	)

	$value = $CapaSDK.RemoveUnitFromReinstall($ComputerName)
	return $value
}
