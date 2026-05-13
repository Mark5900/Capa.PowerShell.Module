<#
	.SYNOPSIS
		Adds a unit to a folder.

	.DESCRIPTION
		Adds the specified unit to the specified folder path by calling the CapaSDK
		method AddUnitToFolder.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to move.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER FolderStructure
		Destination folder structure.

	.PARAMETER CreateFolder
		Whether to create missing folders. Valid values are true and false.
		Default is false.

	.EXAMPLE
		PS C:\> Add-CapaUnitToFolder -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -FolderStructure 'Pester\\Computers' -CreateFolder true

		Moves PC-01 to Pester\\Computers and creates missing folders.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247310/Add+unit+to+folder
#>
function Add-CapaUnitToFolder {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$FolderStructure,
		[ValidateSet('true', 'false')]
		[string]$CreateFolder = 'false'
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToFolder')) {
		throw 'CapaSDK does not contain method AddUnitToFolder.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Move to folder '$FolderStructure' (CreateFolder=$CreateFolder)"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$aUnits = $CapaSDK.AddUnitToFolder($UnitName, $UnitType, $FolderStructure, $CreateFolder)

	return $aUnits
}
