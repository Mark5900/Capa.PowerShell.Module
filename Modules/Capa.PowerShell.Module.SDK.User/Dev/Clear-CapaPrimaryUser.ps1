<#
	.SYNOPSIS
		Clear the primary user on a unit.
	
	.DESCRIPTION
		Clear the primary user on a unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER Uuid
		The UUID of the unit or device.
	
	.EXAMPLE
		PS C:\> Clear-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247356/Clear+Primary+User
#>
function Clear-CapaPrimaryUser {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$Uuid
	)
	
	$value = $CapaSDK.ClearPrimaryUser($Uuid)
	return $value
}
