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
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Active', 'Inactive')]
		[string]$Status = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitStatus')) {
		throw 'CapaSDK does not contain method SetUnitStatus.'
	}

	if ($PSCmdlet.ShouldProcess($UnitName, "Set unit status to '$Status'")) {
		$aUnits = $CapaSDK.SetUnitStatus($UnitName, $Status)
		return $aUnits
	}
}

