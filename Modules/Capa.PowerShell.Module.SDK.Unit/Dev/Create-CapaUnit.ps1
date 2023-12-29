# TODO: #204 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247364/Create+unit

	.DESCRIPTION
		A detailed description of the Create-CapaUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER LinkToManagementServerID
		A description of the LinkToManagementServerID  parameter.

	.PARAMETER Status
		A description of the Status parameter.

	.PARAMETER Uuid
		A description of the Uuid  parameter.

	.PARAMETER SerialNumber
		A description of the SerialNumber  parameter.

	.PARAMETER UnitDeviceType
		A description of the UnitDeviceType parameter.

	.EXAMPLE
				PS C:\> Create-CapaUnit -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer -LinkToManagementServerID  $value4

	.NOTES
		Additional information about the function.
#>
function Create-CapaUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[int]$LinkToManagementServerID,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Active', 'Inactive')]
		[String]$Status = 'Active',
		[String]$Uuid = '',
		[String]$SerialNumber = '',
		[ValidateSet('Windows', 'OSX', 'iOS', 'Android', 'WindowsPhone')]
		[String]$UnitDeviceType = ''
	)

	if ($UnitDeviceType -eq '') {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status)
	} else {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status, $Uuid, $SerialNumber, $UnitDeviceType)
	}

	return $value
}
