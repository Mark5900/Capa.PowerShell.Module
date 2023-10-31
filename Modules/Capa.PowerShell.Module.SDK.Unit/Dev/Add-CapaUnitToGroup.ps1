# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247318/Add+unit+to+group
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247332/Add+unit+to+group+BU

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER GroupName
		A description of the GroupName parameter.

	.PARAMETER GroupType
		A description of the GroupType parameter.

	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName parameter.

	.EXAMPLE
		PS C:\> Add-CapaUnitToGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -GroupName 'Value4' -GroupType Calendar

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', 'Printer')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Reinstall', 'Security', 'Static', 'Dynamic_SQL', 'Dynamic_ADSI')]
		[string]$GroupType,
		[String]$BusinessUnitName = ''
	)

	if (($GroupType -eq 'Dynamic_SQL' -or $GroupType -eq 'Dynamic_ADSI') -and $UnitType -ne 'Printer') {
		Write-Error "GroupType $GroupType only works for UnitType Printer"
		return 'False'
	} else {
		if ($BusinessUnitName -eq '') {
			$value = $CapaSDK.AddUnitToGroup($UnitName, $UnitType, $GroupName, $GroupType, $BusinessUnitName)
		} else {
			$value = $CapaSDK.AddUnitToGroupBU($UnitName, $UnitType, $GroupName, $GroupType)
		}

		return $value
	}
}
