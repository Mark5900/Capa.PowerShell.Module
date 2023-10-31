# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247758/Set+unit+status

	.DESCRIPTION
		A detailed description of the Set-CapaUnitStatus function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER Status
		A description of the Status parameter.

	.EXAMPLE
				PS C:\> Set-CapaUnitStatus -CapaSDK $value1 -UnitName "" -Status ""

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitStatus {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Active', 'Inactive')]
		[string]$Status = ''
	)

	$aUnits = $CapaSDK.SetUnitStatus($UnitName, $Status)

	Return $aUnits
}

