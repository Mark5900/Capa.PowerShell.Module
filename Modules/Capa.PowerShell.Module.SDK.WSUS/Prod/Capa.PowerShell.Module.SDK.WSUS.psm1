
<#
	.SYNOPSIS
		Gets a list of WSUS groups.

	.DESCRIPTION
		Gets a list of WSUS groups.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PointID
		The IS of the WSUS point.

	.EXAMPLE
			Get-CapaWSUSGroups -CapaSDK $CapaSDK -PointID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247844/Get+WSUS+Groups
#>
function Get-CapaWSUSGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$PointID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetWSUSGroups')) {
		throw 'CapaSDK does not contain method GetWSUSGroups.'
	}

	$aUnits = $CapaSDK.GetWSUSGroups($PointID)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 3
		if ($aItem.Count -lt 3) {
			continue
		}

		[pscustomobject]@{
			ID   = $aItem[0]
			Name = $aItem[1]
			GUID = $aItem[2]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets a list of units linked to a WSUS group.

	.DESCRIPTION
		Gets a list of units linked to a WSUS group.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER WSUSGroupName
		The name of the WSUS group.

	.EXAMPLE
			Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName "WSUS Group"

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247622/Get+WSUS+Group+units
#>
function Get-CapaWSUSGroupUnits {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$WSUSGroupName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetWSUSGroupUnits')) {
		throw 'CapaSDK does not contain method GetWSUSGroupUnits.'
	}

	$aUnits = $CapaSDK.GetWSUSGroupUnits($WSUSGroupName)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';'
		if ($aItem.Count -lt 12) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0]
			Created        = $aItem[1]
			LastExecuted   = $aItem[2]
			Status         = $aItem[3]
			Description    = $aItem[4]
			GUID           = $aItem[5]
			ID             = $aItem[7]
			TypeName       = $aItem[8]
			UUID           = $aItem[9]
			IsMobileDevice = $aItem[10]
			Location       = $aItem[11]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Get a list of WSUS points.

	.DESCRIPTION
		Get a list of WSUS points.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
			Get-CapaWSUSPoints -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247854/Get+WSUS+points
#>
function Get-CapaWSUSPoints {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetWSUSPoints')) {
		throw 'CapaSDK does not contain method GetWSUSPoints.'
	}

	$aUnits = $CapaSDK.GetWSUSPoints()
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 3
		if ($aItem.Count -lt 3) {
			continue
		}

		[pscustomobject]@{
			ID   = $aItem[0]
			Name = $aItem[1]
			GUID = $aItem[2]
		}
	}

	return @($oaUnits)
}


