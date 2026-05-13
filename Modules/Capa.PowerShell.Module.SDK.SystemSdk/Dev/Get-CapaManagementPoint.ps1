<#
	.SYNOPSIS
		Get management points or a specific management point.

	.DESCRIPTION
		If CmpId is not specified, all management points are returned.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER CmpId
		The ID of the management point to return. If omitted, all management points are returned.

	.EXAMPLE
				PS C:\> Get-CapaManagementPoint -CapaSDK $value1 -CmpId $value2

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247106/Get+management+point
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247116/Get+management+points
#>
function Get-CapaManagementPoint {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[int]$CmpId
	)

	$oaUnits = @()

	if (-not $PSBoundParameters.ContainsKey('CmpId')) {
		$aUnits = $CapaSDK.GetManagementPoints()
	} else {
		$aUnits = $CapaSDK.GetManagementPoint($CmpId)
	}

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Id          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Drive       = $aItem[3];
			GUID        = $aItem[4];
			LocalFolder = $aItem[5];
			Server      = $aItem[6];
			Share       = $aItem[7];
			ParentGUID  = $aItem[8]
		}
	}

	return $oaUnits
}
