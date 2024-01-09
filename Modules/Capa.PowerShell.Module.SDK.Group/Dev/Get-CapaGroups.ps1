# TODO: #119 Update and add tests

<#
	.SYNOPSIS
		Get groups.

	.DESCRIPTION
		Get either all groups or from all groups from specific business unit.

	.PARAMETER CapaSDK
		CapaSDK object.

	.PARAMETER Type
		If specified, only groups of this type will be returned.
		Can be one of the following: Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.

	.PARAMETER BusinessUnit
		If specified, only groups from this business unit will be returned.

	.EXAMPLE
		PS C:\> Get-CapaGroups -CapaSDK $CapaSDK

	.EXAMPLE
		PS C:\> Get-CapaGroups -CapaSDK $CapaSDK -GroupType Dynamic_ADSI

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246280/Get+groups
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246290/Get+groups+on+Business+Unit
#>
function Get-CapaGroups {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType = '',
		[string]$BusinessUnit = ''
	)

	$oaUnits = @()

	if ($BusinessUnit -eq '') {
		$aUnits = $CapaSDK.GetGroups($GroupType)
	} Else {
		If ($GroupType -eq '') {
			$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit)
		} Else {
			$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit, $GroupType)
		}
	}

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')

		if ($aItem[2] -eq '1') {
			$UnitType = 'Computer'
		} else {
			$UnitType = 'User'
		}

		$oaUnits += [pscustomobject]@{
			Name         = $aItem[0];
			Type         = $aItem[1];
			UnitTypeID   = $aItem[2];
			UnitTypeName = $UnitType;
			Description  = $aItem[3];
			GUID         = $aItem[4];
			ID           = $aItem[5]
		}
	}

	Return $oaUnits
}
