# TODO: #222 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247572/Get+units

	.DESCRIPTION
		A detailed description of the Get-CapaUnits function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER Type
		A description of the Type parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnits -CapaSDK $value1

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnits {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = '',
		[string]$BusinessUnit = ''
	)

	$oaUnits = @()

	if ($BusinessUnit -eq '') {
		$aUnits = $CapaSDK.GetUnits($Type)
	} else {
		if ($UnitType -eq '') {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit)
		} Else {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit, $UnitType)
		}
	}

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnits
}
