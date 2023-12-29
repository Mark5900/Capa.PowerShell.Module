# TODO: #175 Update and add tests

<#
	.SYNOPSIS
		Returns all none inventory packages.

	.DESCRIPTION
		Returns all none inventory packages.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.EXAMPLE
				PS C:\> Get-CapatAllNoneInventoryPackages -CapaSDK $CapaSDK -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246900/Get+all+none+inventory+packages
#>
function Get-CapatAllNoneInventoryPackages {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[string]$PackageType = ''
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetAllNoneInventoryPackages($PackageType)

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
