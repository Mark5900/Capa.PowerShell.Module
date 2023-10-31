# TODO: Update and add tests

<#
	.SYNOPSIS
		Gets a list of OS Disk Configurations.

	.DESCRIPTION
		Gets a list of OS Disk Configurations.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER OSPointID
		The ID of the OS Point.

	.EXAMPLE
		PS C:\> Get-CapaOSDiskConfigration -CapaSDK $CapaSDK -OSPointID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246664/Get+OS+disk+configurations
#>
function Get-CapaOSDiskConfigration {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$OSPointID
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetOSDiskConfiguration($OSPointID)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Comment     = $aItem[2];
			GUID        = $aItem[3];
			Laptop      = $aItem[4];
			LeaveDisk   = $aItem[5];
			WorkStation = $aItem[6]
		}
	}

	Return $oaUnits
}
