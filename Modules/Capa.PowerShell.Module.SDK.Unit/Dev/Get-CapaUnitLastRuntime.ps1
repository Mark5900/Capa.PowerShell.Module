# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247492/Get+unit+last+runtime

	.DESCRIPTION
		A detailed description of the Get-CapaUnitLastRuntime function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitLastRuntime -CapaSDK $value1 -UnitName "" -UnitType ""

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitLastRuntime {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType = ''
	)

	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	} else {
		$UnitType = '2'
	}

	$aUnits = $CapaSDK.GetUnitLastRuntime($UnitName, $UnitType)

	Return $aUnits
}
