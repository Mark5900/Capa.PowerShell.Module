<#
	.SYNOPSIS
		Gets units from CapaInstaller.

	.DESCRIPTION
		Gets units by type, or from a specific business unit, by calling CapaSDK.
		If BusinessUnit is provided, data is retrieved with GetUnitsOnBusinessUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER Type
		Optional unit type filter. Valid values are Computer and User.

	.PARAMETER BusinessUnit
		Optional business unit name. When provided, units are fetched from
		the specified business unit.

	.EXAMPLE
		PS C:\> Get-CapaUnits -CapaSDK $CapaSDK -Type Computer

		Returns computer units.

	.EXAMPLE
		PS C:\> Get-CapaUnits -CapaSDK $CapaSDK -BusinessUnit 'Default'

		Returns units on business unit Default.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247572/Get+units
#>
function Get-CapaUnits {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $false)]
		[string]$Type = '',
		[Parameter(Mandatory = $false)]
		[AllowEmptyString()]
		[string]$BusinessUnit = ''
	)

	if (-not [string]::IsNullOrWhiteSpace($Type) -and @('Computer', 'User') -notcontains $Type) {
		throw "Type must be either 'Computer' or 'User'."
	}

	if (-not [string]::IsNullOrWhiteSpace($BusinessUnit) -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitsOnBusinessUnit')) {
		throw 'CapaSDK does not contain method GetUnitsOnBusinessUnit.'
	}

	if ([string]::IsNullOrWhiteSpace($BusinessUnit) -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnits')) {
		throw 'CapaSDK does not contain method GetUnits.'
	}

	if ([string]::IsNullOrWhiteSpace($BusinessUnit)) {
		$aUnits = $CapaSDK.GetUnits($Type)
	} else {
		if ([string]::IsNullOrWhiteSpace($Type)) {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit)
		} else {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit, $Type)
		}
	}

	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 11
		if ($aItem.Count -lt 11) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[6];
			TypeName       = $aItem[7];
			UUID           = $aItem[8];
			IsMobileDevice = $aItem[9];
			Location       = $aItem[10]
		}
	}

	return @($oaUnits)
}
