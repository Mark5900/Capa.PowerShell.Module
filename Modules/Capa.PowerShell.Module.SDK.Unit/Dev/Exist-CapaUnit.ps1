<#
	.SYNOPSIS
		Checks whether a unit exists by name/type or UUID.

	.DESCRIPTION
		Checks whether a unit exists in CapaInstaller by using either the NameType
		parameter set (UnitName + UnitType) or the Uuid parameter set.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to check.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER Uuid
		UUID of the unit to check.

	.EXAMPLE
		PS C:\> Exist-CapaUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Checks whether PC-01 exists as a computer unit.

	.EXAMPLE
		PS C:\> Exist-CapaUnit -CapaSDK $CapaSDK -Uuid '4f5e6d7c-8b9a-4c3d-9e0f-1a2b3c4d5e6f'

		Checks whether a unit exists with the specified UUID.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247388/Exist+unit
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247418/Exist+uuid
#>
function Exist-CapaUnit {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
		[String]$Uuid
	)

	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUnit')) {
			throw 'CapaSDK does not contain method ExistUnit.'
		}
		$value = $CapaSDK.ExistUnit($UnitName, $UnitType)
	} else {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUUID')) {
			throw 'CapaSDK does not contain method ExistUUID.'
		}
		$value = $CapaSDK.ExistUUID($Uuid)
	}

	return $value
}
