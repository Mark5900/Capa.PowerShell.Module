# TODO: Update and add tests

<#
	.SYNOPSIS
		Get a list of packages.

	.DESCRIPTION
		Get a list of packages and if a BusinessUnit is specified, get the packages on that BusinessUnit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER Type
		If specified, only get packages of this type. Can be either Computer or User.

	.PARAMETER BusinessUnit
		If specified, only get packages on this BusinessUnit.

	.EXAMPLE
				PS C:\> Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer'

	.EXAMPLE
				PS C:\> Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer' -BusinessUnit 'TestBusinessUnit'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246954/Get+packages
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246964/Get+packages+on+Business+Unit
#>
function Get-CapaPackages {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = '',
		[String]$BusinessUnit = ''
	)

	$oaUnits = @()

	if ($BusinessUnit -eq '') {
		$aUnits = $CapaSDK.GetPackages($Type)
	} else {
		$aUnits = $CapaSDK.GetPackagesOnBusinessUnit($BusinessUnit)
	}

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[6];
			GUID               = $aItem[7];
			ID                 = $aItem[8];
			IsInteractive      = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode        = $aItem[12];
			Priority           = $aItem[13];
			ServerDeploy       = $aItem[14]
		}
	}

	Return $oaUnits
}
