# TODO: #200 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247310/Add+unit+to+folder

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToFolder function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER FolderStructure
		A description of the FolderStructure parameter.

	.PARAMETER CreateFolder
		Default is false

	.EXAMPLE
				PS C:\> Add-CapaUnitToFolder -CapaSDK $value1 -UnitName "" -UnitType "" -FolderStructure ""

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType = '',
		[Parameter(Mandatory = $true)]
		[string]$FolderStructure = '',
		[ValidateSet('true', 'false')]
		[string]$CreateFolder
	)

	$aUnits = $CapaSDK.AddUnitToFolder($UnitName, $UnitType, $FolderStructure, $CreateFolder)

	Return $aUnits
}
