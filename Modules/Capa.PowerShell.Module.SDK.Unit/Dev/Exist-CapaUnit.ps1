# TODO: #206 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247388/Exist+unit
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247418/Exist+uuid

	.DESCRIPTION
		A detailed description of the Exist-CapaUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Uuid
		A description of the Uuid  parameter.

	.EXAMPLE
		PS C:\> Exist-CapaUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Exist-CapaUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$Uuid
	)

	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$value = $CapaSDK.ExistUnit($UnitName, $UnitType)
	} else {
		$value = $CapaSDK.ExistUUID($Uuid)
	}

	return $value
}
